#!/bin/bash

t32b='../template/portainer-v2-arm32.json'
t64b='../template/portainer-v2-arm64.json'
appinfo='./appinfo.json'
appsfolder='../template/apps'

mkdir -p "$appsfolder"

Napps=$( jq '.templates | length' "$t64b" )
for app in $(seq 0 $(( Napps - 1 ))); do
	info=$( jq ".templates[$app]" "$t64b" )
	Title=$( echo "$info" | jq ".title" )
	Type=$( echo "$info" | jq ".type" )

	fileName="$appsfolder/$( echo "$Title" | tr -d '"' | tr '[:upper:]' '[:lower:]' | tr ' /' '--' ).json"

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

	json=$( jq '.apps[] | select(.Title=='"$Title"')' "$appinfo" )

	# Web
	if value=$( echo "$json" | jq -e '.Web' | tr -d '"' ) ; then
		info=$( echo "$info" | jq --arg v "$value" '. += {"webpage": $v}' )
	fi

	# Official Documentation
	if value=$( echo "$json" | jq -e '.OfficialDoc' | tr -d '"' ) ; then
		info=$( echo "$info" | jq --arg v "$value" '. += {"officialDoc": $v}' )
	fi

	# Youtube Video
	if value=$( echo "$json" | jq -e '.VideoID' ) ; then
		info=$( echo "$info" | jq '. += {"videoID": '"$value"'}' )
	fi

	# Pi-Hosted Doc
	if id=$( echo "$json" | jq -e '.DocID' ) ; then
		value=$( jq '.docs[] | select(.ID=='"$id"') | .File' "$appinfo" | tr -d '"' )
		info=$( echo "$info" | jq --arg v "$value" '. += {"piHostedDoc": $v}' )
	fi

	# Pre-Install Script Doc
	if id=$( echo "$json" | jq -e '.ScriptID' ) ; then
		value=$( jq '.tools[] | select(.ID=='"$id"') | .File' "$appinfo" | tr -d '"' )
		info=$( echo "$info" | jq --arg v "$value" '. += {"preInstallScript": $v}' )
	fi

	# Extra scripts
	if ExtraID=$( echo "$json" | jq -e '.ExtraID' ) ; then
		# If only one entry
		if [ "$(echo "$ExtraID" | wc -l )" == "1" ]; then
			value=$(jq ".tools[] | select(.ID==$ExtraID) | .File" "$appinfo" | tr -d '"' )
			info=$( echo "$info" | jq --arg v "$value" '. += {"extraScript": $v}' )

		# If multiples entries
		else
			n_ext=$(echo "$ExtraID" | jq '. | length')
			value='['
			for n in $(seq 0 $(( n_ext - 1 ))); do
				extID=$(echo "$ExtraID" | jq ".[$n]" | tr -d \")
				v=$(jq ".tools[] | select(.ID==$extID) | .File" "$appinfo" | tr -d '"')
				value="$value $v,"
			done
			value="${value:0:-1} ]"
			info=$( echo "$info" | jq --arg v "$value" '. += {"extraScript": $v}' )
		fi
	else
		unset ExtraURL ExtraID
	fi

	echo "$info" | jq --tab --sort-keys '.' > "$fileName"

	unset has32 info Title Type img32 stack32 fileName
done
