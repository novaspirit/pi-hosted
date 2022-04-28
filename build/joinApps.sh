#!/bin/bash

# Blank portainer template (32 and 64 bits)
json32='{"version":"2","templates":[]}'
json64='{"version":"2","templates":[]}'

# File variables
appinfo='build/info.json'
Oldtemplate32='pi-hosted_template/template/portainer-v2.json'
template32='template/portainer-v2-arm32.json'
template64='template/portainer-v2-arm64.json'

# App info
repo='https://github.com/pi-hosted/pi-hosted/blob/master/'
header='<h3>Template created by Pi-Hosted Series</h3><b>Check our Github page: <a href="https://github.com/pi-hosted/pi-hosted" target="_blank">https://github.com/pi-hosted/pi-hosted</a></b><br>'

# Run script from base directory
scriptDir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$scriptDir/.." || exit

# Parsing all json files in apps folder
for app in template/apps/*.json; do
	# Output app name to easy debug
	echo "adding $app to template..."

	# Adding app template to 32 and 64 bits variables
	appjson=$( cat "$app" )

	# Improve Notes
	note=$( echo "$appjson" | jq '.note' )
	# Clean Notes
	[ "$note" == "null" ] && unset note
	note=${note:1: -1}

	# Official Webpage
	if oweb=$( echo "$appjson" | jq -e '.webpage' ) ; then
		oweb="<br><b>Official Webpage: </b><a href=\"${oweb:1:-1}\" target=\"_blank\">${oweb:1:-1}</a>"
		appjson=$( echo "$appjson" | jq 'del(.webpage)' )
	else
		unset oweb
	fi

	# Official Documentation
	if odoc=$( echo "$appjson" | jq -e '.officialDoc' ) ; then
		odoc="<br><b>Official Docker Documentation: </b><a href=\"${odoc:1:-1}\" target=\"_blank\">${odoc:1:-1}</a>"
		appjson=$( echo "$appjson" | jq 'del(.officialDoc)' )
	else
		unset odoc
	fi

	# Pi-Hosted Documentation
	if PHDoc=$( echo "$appjson" | jq -e '.piHostedDoc' ) ; then
		PHDoc="<br><b>Pi-Hosted dedicated documentation: </b><a href=\"${repo}docs/${PHDoc:1:-1}\" target=\"_blank\">${PHDoc:1:-1}</a>"
		appjson=$( echo "$appjson" | jq 'del(.piHostedDoc)' )
	else
		unset PHDoc
	fi

	if Script=$( echo "$appjson" | jq -e '.preInstallScript' ) ; then
		Script="<br><b>Pre-installation script must be RAN before you install: </b><a href=\"${repo}tools/${Script:1:-1}\" target=\"_blank\">${Script:1:-1}</a>"
		appjson=$( echo "$appjson" | jq 'del(.preInstallScript)' )
	else
		unset Script
	fi

	if VideoID=$( echo "$appjson" | jq -e '.videoID' ) ; then
		VideoURL=$( jq '.youtube[] | select(.ID=='"$VideoID"') | .URL' "$appinfo" )
		VideoTitle=$( jq '.youtube[] | select(.ID=='"$VideoID"') | .Title' "$appinfo" | tr -d '"')
		VideoURL="<br><b>Youtube Video: </b><a href=$VideoURL target=\"_blank\">$VideoTitle</a><br>"
		appjson=$( echo "$appjson" | jq 'del(.videoID)' )
	else
		unset VideoID VideoURL
	fi

	if ExtraScript=$( echo "$appjson" | jq -e '.extraScript' ) ; then
		appjson=$( echo "$appjson" | jq 'del(.extraScript)' )
		# If only one entry
		if [ "$(echo "$ExtraScript" | wc -l )" == "1" ]; then
			ExtraHTML="<br><b>Extra useful script: </b><a href=\"${repo}tools/${ExtraScript:1:-1}\" target=\"_blank\">${ExtraScript:1:-1}</a>"

		# If multiples entries
		else
			n_ext=$(echo "$ExtraScript" | jq '. | length')
			ExtraHTML="<br><b>Extra useful scripts:</b><br><ul>"
			for n in $(seq 0 $(( n_ext - 1 ))); do
				ext=$(echo "$ExtraScript" | jq ".[$n]" | tr -d '"')
				ExtraHTML="$ExtraHTML<li><a href=\"${repo}tools/${ext}\" target=\"_blank\">$ext</a></li>"
			done
			ExtraHTML="$ExtraHTML</ul>"
		fi
	else
		unset ExtraHTML ExtraScript
	fi

	# Full Compiled Note
	note="$header$oweb$odoc$PHDoc<br>$Script$ExtraHTML<br>$VideoURL<br>$note"

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

# Create Templates
echo "$json32" | jq --tab '.templates |= sort_by(.title | ascii_upcase)' > "$template32"
echo "$json64" | jq --tab '.templates |= sort_by(.title | ascii_upcase)' > "$template64"

# Keep old template up to date
cp -f "$template32" "$Oldtemplate32"
