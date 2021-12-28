#!/bin/bash

# Standard file locations
homedir='../'
. env.sh

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
	DocID=$( echo "$info" | jq '.DocID' )
	if [ "$DocID" != "null" ] ; then
		DocFile=$( jq ".docs[] | select(.ID==$DocID) | .File" "$appinfo" | tr -d '"' )
		DocMD="[Install Doc]($Docs$DocFile)"
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

## Generate Doc Table
unset table
nDocs=$( jq '.docs | length' "$appinfo")
for doc in $(seq 0 $(( nDocs - 1 ))); do
	info=$( jq ".docs[$doc]" "$appinfo" )

	# Get Doc Path
	FILE=$( echo "$info" | jq '.File' | tr -d '"' )

	# Get Doc Description
	DESC=$( echo "$info" | jq '.Description' | tr -d '"' )

	line="|[$DESC]($Docs$FILE)|"
	if [ "$doc" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
insertTable '<<<<< DOCS TABLE HERE >>>>>' "$tmpreadme2"

## Generate Tools Table
unset table
nTools=$( jq '.tools | length' "$appinfo")
for tool in $(seq 0 $(( nTools - 1 ))); do
	info=$( jq ".tools[$tool]" "$appinfo" )

	# Get Tool Path
	FILE=$( echo "$info" | jq '.File' | tr -d '"' )
	FILE="[$FILE]($Scripts$FILE)"

	# Get Tool Description
	DESC=$( echo "$info" | jq '.Description' | tr -d '"' )

	# Get Tool runner
	EXEC=$( echo "$info" | jq '.Exec' | tr -d '"' )
	[ "$EXEC" == "null" ] && EXEC="bash"

	# Get Tool wget link
	WGET=$( echo "$info" | jq '.wget' | tr -d '"' )
	if [ "$WGET" != "null" ]; then
		WGET="wget -qO- $WGET \| $EXEC"
	else
		unset WGET
	fi

	# Get Tool Installation Doc
	DocID=$( echo "$info" | jq '.DocID')
	if [ "$DocID" != "null" ]; then
		DocFile=$(jq ".docs[] | select(.ID==$DocID) | .File" "$appinfo" | tr -d '"')
		DocLink="<br>[Installation Document]($Docs$DocFile)"
	else
		unset DocLink
	fi

	line="|$FILE|$DESC$DocLink|$WGET|"
	if [ "$tool" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
insertTable '<<<<< TOOLS TABLE HERE >>>>>' "$tmpreadme2"

cp -f "$tmpreadme2" "$README"
