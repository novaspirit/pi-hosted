#!/bin/bash

# start script from it's folder
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit

# Standard file locations
homedir='../../'
. ../env.sh

## Generate Tools Table
unset table
nTools=$( jq '.tools | length' "$appinfo")
for tool in $(seq 0 $(( nTools - 1 ))); do
	info=$( jq ".tools | sort_by(.File) | .[$tool]" "$appinfo" )

	# Get Tool Path
	FILE=$( echo "$info" | jq '.File' | tr -d '"' )
	FILE="[$FILE]($Scripts$FILE)"

	# Get Tool Description
	DESC=$( echo "$info" | jq '.Description' | tr -d '"' )

	# Get Tool Type
	TYPE=$( echo "$info" | jq '.Type' | tr -d '"' )
	[ "$TYPE" == "null" ] && TYPE="Install"

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
	Doc=$( echo "$info" | jq '.Doc' | tr -d '"' )
	if [ "$Doc" != "null" ]; then
		DocLink="[Documentation]($Docs$Doc)"
	else
		unset DocLink
	fi

	line="|$FILE|$DocLink|$TYPE|$DESC|$WGET|"
	if [ "$tool" == "0" ] ; then
		table=$line
	else
		table=$( echo -e "$table\n$line")
	fi
done
cp -f "$TOOLSREADME_TEMPLATE" "$TOOLSREADME"
echo -e "$table" >> "$TOOLSREADME"
