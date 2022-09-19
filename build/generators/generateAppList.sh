#!/bin/bash

# start script from it's folder
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit

# Standard file locations
homedir='../../'
. ../env.sh
docIconBlue="![](../build/images/blue_doc_icon.png)"
docIconRed="![](../build/images/red_doc_icon.png)"
scriptIcon="![](../build/images/script_icon.png)"

# Create AppList title
cp -f "$AppList_TEMPLATE" "$AppList"

# Total apps per arch
for Arch in {arm32,arm64,amd64}; do
	total=$(grep -lE '"(image|stackfile)(_'"$Arch"')?":' "$appsfolder"/*.json | wc -l )
	sed -i "s/XXX_${Arch}_XXX/$total/" "$AppList"
done
total=$(find "$appsfolder" -type f -iname '*.json' | wc -l )
sed -i "s/XXX_total_XXX/$total/" "$AppList"

# Generate App Table
while IFS='' read -u 9 -r appfile || [[ -n $appfile ]]; do

	# Clear previous variables
	unset doc script vid oweb odoc type

	hasArm32=':x:'
	hasArm64=':x:'
	hasAmd64=':x:'

	# Get app json
	appconf=$( jq '.' "$appfile" )

	# App Title
	App=$( echo "$appconf" | jq '.title' | tr -d '"' )

	# App Architecture
	# tag with no specific architecture is added to all of them
	if echo "$appconf" | jq -e '.image' &> /dev/null || echo "$appconf" | jq -e '.repository.stackfile' &> /dev/null ; then
		hasArm32=':heavy_check_mark:'
		hasArm64=':heavy_check_mark:'
		hasAmd64=':heavy_check_mark:'

	# Parse tags with specific architectures
	else
		# Arm32
		if echo "$appconf" | jq -e '.image_arm32' &> /dev/null || echo "$appconf" | jq -e '.repository.stackfile_arm32' &> /dev/null ; then hasArm32=':heavy_check_mark:' ; fi

		# Arm64
		if echo "$appconf" | jq -e '.image_arm64' &> /dev/null || echo "$appconf" | jq -e '.repository.stackfile_arm64' &> /dev/null ; then hasArm64=':heavy_check_mark:' ; fi

		# Amd64
		if echo "$appconf" | jq -e '.image_amd64' &> /dev/null || echo "$appconf" | jq -e '.repository.stackfile_amd64' &> /dev/null ; then hasAmd64=':heavy_check_mark:' ; fi
	fi

	# Apps Type
	apptype=$( echo "$appconf" | jq '.type' | tr -d '"' )

	# Get App Webpage from app info
	oweb=$(echo "$appconf" | jq ".webpage" | tr -d '"' )
	if [ "$oweb" != "null" ]; then
		oweb="[$App]($oweb)"
	else
		oweb="$App"
	fi

	# Get App Official Doc from app info
	odoc=$(echo "$appconf" | jq ".officialDoc" | tr -d '"' )
	if [ "$odoc" != "null" ]; then
		odoc="[$docIconBlue]($odoc)"
	else
		unset odoc
	fi

	# Get Doc from app info
	doc=$(echo "$appconf" | jq ".piHostedDoc" | tr -d '"' )
	if [ "$doc" != "null" ]; then
		doc="[$docIconRed]($Docs$doc)"
	else
		unset doc
	fi

	# Get Install Script from app info
	script=$(echo "$appconf" | jq ".preInstallScript" | tr -d '"' )
	if [ "$script" != "null" ]; then
		script="[$scriptIcon]($Scripts$script)"
	else
		unset script
	fi

	# Get Video from app info
	if vidlist=$( echo "$appconf" | jq -e ".videoID" ) ; then
		# If only one entry
		if [ "$(echo "$vidlist" | wc -l )" == "1" ]; then
			vidURL=$(jq ".youtube[] | select(.ID==$vidlist) | .URL" "$appinfo" | tr -d '"')
			vidTitle=$(jq ".youtube[] | select(.ID==$vidlist) | .Title" "$appinfo" | tr -d '"')
			vidCh=$(jq ".youtube[] | select(.ID==$vidlist) | .Channel" "$appinfo" | tr -d '"')
			vid="[![$vidTitle](../build/images/yt-badge-${vidCh}.png \"$vidTitle\")]($vidURL)"

		# If multiple entries
		else
			n_vid=$(echo "$vidlist" | jq '. | length')
			for n in $(seq 0 $(( n_vid - 1 ))); do
				vidd=$(echo "$vidlist" | jq ".[$n]" )
				vidURL=$(jq ".youtube[] | select(.ID==$vidd) | .URL" "$appinfo" | tr -d '"')
				vidTitle=$(jq ".youtube[] | select(.ID==$vidd) | .Title" "$appinfo" | tr -d '"')
				vidCh=$(jq ".youtube[] | select(.ID==$vidd) | .Channel" "$appinfo" | tr -d '"')
				if [ "$n" == "0" ] ; then
					vid="[![$vidTitle](../build/images/yt-badge-${vidCh}.png \"$vidTitle\")]($vidURL)"
				else
					vid="$vid<br>[![$vidTitle](../build/images/yt-badge-${vidCh}.png \"$vidTitle\")]($vidURL)"
				fi
			done
		fi
	else
		unset vid
	fi

	# Building App Line
	line="|$oweb|$hasArm32|$hasArm64|$hasAmd64|$apptype| $odoc | $doc | $script | $vid |"

	# Change container type to string (Default to Container when not set)
	line="${line//|1|/|Container|}"
	line="${line//|null|/|Container|}"
	line="${line//|3|/|Stack|}"

	# Add line to List
	echo "$line" >> "$AppList"

done 9< <( LC_COLLATE=en_US.utf8 ls $appsfolder/*.json )
