#!/bin/bash

# start script from it's folder
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit

# Standard file locations
homedir='../'
. env.sh

## Generate Doc Table
unset table
nDocs=$( jq '.docs | length' "$appinfo")
for doc in $(seq 0 $(( nDocs - 1 ))); do
	info=$( jq ".docs | sort_by(.File) | .[$doc]" "$appinfo" )

	# Get Doc ID
	ID=$( echo "$info" | jq '.ID' | tr -d '"' )

	# Get Doc Path
	FILE=$( echo "$info" | jq '.File' | tr -d '"' )

	# Get Doc Description
	DESC=$( echo "$info" | jq '.Description' | tr -d '"' )

	# YouTube Video
	YT=$( jq ".youtube[] | select(.DocID==$ID) | .URL" "$appinfo" )
	[ "$YT" != "" ] && YT="[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=plastic&logo=youtube&logoColor=white)]($YT)"

	# Apps
	APPS=$( jq ".apps[] | select(.DocID==$ID) | .Title" "$appinfo" | tr -d '"' )
	if [ "$APPS" != "" ] && [ "$( echo "$APPS" | wc -l)" -gt "1" ] ; then
		unset temp_app
		while IFS="" read -r app || [ -n "$app" ]
		do
			if [ -z "$temp_app" ] ; then
				temp_app="$app"
			else
				temp_app="$temp_app<br>$app"
			fi
		done < <( echo "$APPS" )
		APPS="$temp_app"
	fi

	line="|[$FILE]($Docs$FILE)|$DESC|$APPS|$YT|"
	if [ "$doc" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
cp -f "$DocList_TEMPLATE" "$DocList"
echo -e "$table" >> "$DocList"
