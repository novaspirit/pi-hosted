#!/bin/bash

# Blank portainer template (32 and 64 bits)
json32='{"version":"2","templates":[]}'
json64='{"version":"2","templates":[]}'
appinfo='../build/appinfo.json'
repo='https://github.com/pi-hosted/pi-hosted/blob/master/'
header='<h3>Template created by Pi-Hosted Series</h3><b>Check our Github page: <a href="https://github.com/pi-hosted/pi-hosted" target="_blank">https://github.com/pi-hosted/pi-hosted</a></b><br>'

# Parsing all json files in apps folder
for app in apps/*.json; do
	# Adding app template to 32 and 64 bits variables
	appjson=$( cat "$app" )

	# Improve Notes
	note=$( echo "$appjson" | jq '.note' )
	# Clean Notes
	[ "$note" == "null" ] && unset note
	note=${note:1: -1}

	# App Info
	Title=$( echo "$appjson" | jq '.title' )
	info=$( jq '.apps[] | select(.Title=='"$Title"')' "$appinfo" )

	# Official Webpage
	if oweb=$( echo "$info" | jq -e '.Web' | tr -d '"') ; then
		oweb="<br><b>Official Webpage: </b><a href=\"$oweb\" target=\"_blank\">$oweb</a>"
	else
		unset oweb
	fi

	# Official Documentation
	if odoc=$( echo "$info" | jq -e '.OfficialDoc' | tr -d '"' ) ; then
		odoc="<br><b>Official Docker Documentation: </b><a href=\"$odoc\" target=\"_blank\">$odoc</a>"
	else
		unset odoc
	fi

	# Pi-Hosted Documentation
	if DocID=$( echo "$info" | jq -e '.DocID' ) ; then
		DocURL=$( jq '.docs[] | select(.ID=='"$DocID"') | .File' "$appinfo" | tr -d '"')
		DocURL="<br><b>Pi-Hosted dedicated documentation: </b><a href=\"${repo}docs/${DocURL}\" target=\"_blank\">$DocURL</a>"
	else
		unset DocID DocURL
	fi

	if ScriptID=$( echo "$info" | jq -e '.ScriptID' ) ; then
		ScriptURL=$( jq '.tools[] | select(.ID=='"$ScriptID"') | .File' "$appinfo" | tr -d '"')
		ScriptURL="<br><b>Pre-installation script: </b><a href=\"${repo}tools/${ScriptURL}\" target=\"_blank\">$ScriptURL</a>"
	else
		unset ScriptID ScriptURL
	fi

	if VideoID=$( echo "$info" | jq -e '.VideoID' ) ; then
		VideoURL=$( jq '.youtube[] | select(.ID=='"$VideoID"') | .URL' "$appinfo" )
		VideoTitle=$( jq '.youtube[] | select(.ID=='"$VideoID"') | .Title' "$appinfo" | tr -d '"')
		VideoURL="<br><b>Youtube Video: </b><a href=$VideoURL target=\"_blank\">$VideoTitle</a><br>"
	else
		unset VideoID VideoURL
	fi

	if ExtraID=$( echo "$info" | jq -e '.ExtraID' ) ; then
		# If only one entry
		if [ "$(echo "$ExtraID" | wc -l )" == "1" ]; then
			ExtraURL=$(jq ".tools[] | select(.ID==$ExtraID) | .File" "$appinfo" | tr -d '"')
			ExtraURL="<br><b>Extra useful script: </b><a href=\"${repo}tools/${ExtraURL}\" target=\"_blank\">$ExtraURL</a>"

		# If multiples entries
		else
			n_ext=$(echo "$ExtraID" | jq '. | length')
			ExtraURL="<br><b>Extra useful scripts:</b><br><ul>"
			for n in $(seq 0 $(( n_ext - 1 ))); do
				extID=$(echo "$ExtraID" | jq ".[$n]" | tr -d \")
				ext=$(jq ".tools[] | select(.ID==$extID) | .File" "$appinfo" | tr -d '"')
				ExtraURL="$ExtraURL<li><a href=\"${repo}tools/${ext}\" target=\"_blank\">$ext</a></li>"
			done
			ExtraURL="$ExtraURL</ul>"
		fi
	else
		unset ExtraURL ExtraID
	fi

	# Full Compiled Note
	note="$header$oweb$odoc$DocURL<br>$ScriptURL$ExtraURL<br>$VideoURL<br>$note"

	appjson=$( echo "$appjson" | jq --arg n "$note" '.note = $n' )

	# Splitting into 32 and 64 bit jsons
	appjson32=$appjson
	appjson64=$appjson

	# Check if app is to be applied to all (no arch identified)
	# If there is no indication of architecture (32 or 64) on image or stackfile keys
	#   it's to assume that app is to be applied to both templates
	#   else apply specific image/stackfile to indicated architecture
	if  ! echo "$appjson" | grep -qE '"(image|stackfile)":' ; then

		# Parsing 32 bit apps (check if there is an image32 or stackfile32)
		if  echo "$appjson32" | grep -qE '"(image|stackfile)32":' ; then
			# Remove 64 bit info
			appjson32=$( echo "$appjson32" | sed -E 's/"(image|stackfile)32":/"\1":/' )
		else
			# App does not contain 32bit template
			unset appjson32
		fi

		# Parsing 64 bit apps
		if  echo "$appjson64" | grep -qE '"(image|stackfile)64":' ; then
			appjson64=$( echo "$appjson64" | sed -E 's/"(image|stackfile)64":/"\1":/' )
		else
			# App does not contain 64bit template
			unset appjson64
		fi

	fi


	# Appending to json32
	if [[ -n "$appjson32" ]]; then
		# Cleaning App json before adding to template
		appjson32=$( echo "$appjson32" | jq 'del(.image32, .image64, .repository.stackfile32, .repository.stackfile64)')
		json32=$( echo "$json32" | jq --argjson newApp "$appjson32" '.templates += [$newApp]' )
	fi

	# Appending to json64
	if [[ -n "$appjson64" ]]; then
		# Cleaning App json before adding to template
		appjson64=$( echo "$appjson64" | jq 'del(.image32, .image64, .repository.stackfile32, .repository.stackfile64)')
		json64=$( echo "$json64" | jq --argjson newApp "$appjson64" '.templates += [$newApp]' )
	fi

	# clean variables before next loop
	unset appjson32 appjson64 note
done

echo "$json32" | jq --tab '.templates |= sort_by(.title | ascii_upcase)' > port32.json
echo "$json64" | jq --tab '.templates |= sort_by(.title | ascii_upcase)' > port64.json
