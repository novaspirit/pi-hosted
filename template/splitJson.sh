#!/bin/bash

t32b='./portainer-v2-arm32.json'
t64b='./portainer-v2-arm64.json'

Napps=$( jq '.templates | length' "$t64b" )
for app in $(seq 0 $(( Napps - 1 ))); do
	info=$( jq ".templates[$app]" "$t64b" )
	Title=$( echo "$info" | jq ".title" )
	Type=$( echo "$info" | jq ".type" )

	fileName="apps/$( echo "$Title" | tr -d '"' | tr '[:upper:]' '[:lower:]' | tr ' /' '--' ).json"

	info=$( echo "$info" | sed 's/"image":/"image64":/g' | sed 's/"stackfile":/"stackfile64":/g' )

	has32=$( jq 'any(.templates[].title=='"$Title"'; .)' "$t32b" )
	if $has32; then
		if [ "$Type" == "3" ]; then
			stack32=$( jq '.templates[] | select(.title=='"$Title"') | .repository.stackfile' "$t32b" )
			info=$( echo "$info" | jq '.repository += {"stackfile32": '"$stack32"'}' )
		else
			img32=$( jq '.templates[] | select(.title=='"$Title"') | .image' "$t32b" )
			info=$( echo "$info" | jq '. += {"image32": '"$img32"'}' )
		fi
	fi


	echo "$info" | jq --tab --sort-keys '.' > "$fileName"

	unset has32 info Title Type img32 stack32 fileName
done
