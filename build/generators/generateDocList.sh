#!/bin/bash

# start script from it's folder
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit

# Standard file locations
homedir='../../'
. ../env.sh

## Generate Doc Table
unset table
nDocs=$( jq '.docs | length' "$appinfo")
for doc in $(seq 0 $(( nDocs - 1 ))); do
	info=$( jq ".docs | sort_by(.File | ascii_upcase) | .[$doc]" "$appinfo" )

	# Get Doc Path
	FILE=$( echo "$info" | jq '.File' | tr -d '"' )

	# Get Doc Description
	DESC=$( echo "$info" | jq '.Description' | tr -d '"' )

	# YouTube Video
	YT=$( jq ".youtube[] | select(.Doc==\"$FILE\") | .URL" "$appinfo" )
	[ "$YT" != "" ] && YT="[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=plastic&logo=youtube&logoColor=white)]($YT)"

	# Apps
	APPS=$( grep -RlZ "$FILE" "$appsfolder" | xargs -0 jq '.title' | tr -d '"' | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/<br>/g' )

	line="|[$FILE]($Docs$FILE)|$DESC|$APPS|$YT|"
	if [ "$doc" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
cp -f "$DocList_TEMPLATE" "$DocList"
echo -e "$table" >> "$DocList"
