#!/bin/bash

# start script from it's folder
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit

# Standard file locations
homedir='../../'
. ../env.sh

# Temp Files
tmpreadme1=$(mktemp)
tmpreadme2=$(mktemp)

# Delete TempFiles on exit
CleanExit () {
	rm -f "$tmpreadme1"
	rm -f "$tmpreadme2"
}
trap CleanExit 0 1

insertTable () {
	searchstr="$1"
	basefile="$2"

	tableline=$( grep -n "$searchstr" "$basefile" | cut -d: -f1)
	head -n $(( tableline - 1 )) "$basefile" > "$tmpreadme1"
	echo -e "$table" >> "$tmpreadme1"
	tail -n +$(( tableline + 1 )) "$basefile" >> "$tmpreadme1"
	mv "$tmpreadme1" "$tmpreadme2"
}

## Generate YouTube Video Table
unset table
nVideos=$( jq '.youtube | length' "$appinfo")
for vid in $(seq 0 $(( nVideos - 1 ))); do
	info=$( jq ".youtube[$vid]" "$appinfo" )

	# Get Video ID
	ID=$( echo "$info" | jq '.ID' | tr -d '"' )

	# Get Video URL
	URL=$( echo "$info" | jq '.URL' | tr -d '"' )

	# Get Video Title
	TITLE=$( echo "$info" | jq '.Title' | tr -d '"' )

	# Get Video Documentation
	Doc=$( echo "$info" | jq '.Doc' | tr -d '"' )
	if [ "$Doc" != "null" ] ; then
		DocMD="[Install Doc]($Docs$Doc)"
	else
		unset DocMD
	fi

	line="|$ID|[$TITLE]($URL)|$DocMD|"
	if [ "$vid" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
insertTable '<<<<< YOUTUBE TABLE HERE >>>>>' "$README_TEMPLATE"

cp -f "$tmpreadme2" "$README"
