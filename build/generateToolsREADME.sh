#!/bin/bash

# start script from it's folder
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit

# Standard file locations
homedir='../'
. env.sh

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

	# Get Tool Type
	TYPE=$( echo "$info" | jq '.Type' | tr -d '"' )
	[ "$TYPE" == "null" ] && TYPE="Install"

	# Get Tool Installation Doc
	DocID=$( echo "$info" | jq '.DocID')
	if [ "$DocID" != "null" ]; then
		DocFile=$(jq ".docs[] | select(.ID==$DocID) | .File" "$appinfo" | tr -d '"')
		DocLink="[Documentation]($Docs$DocFile)"
	else
		unset DocLink
	fi

	line="|$FILE|$DocLink|$TYPE|$DESC|"
	if [ "$tool" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
cp -f "$TOOLSREADME_TEMPLATE" "$TOOLSREADME"
echo -e "$table" >> "$TOOLSREADME"
