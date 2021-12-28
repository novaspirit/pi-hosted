#!/bin/bash

# Standard file locations
homedir='../'
. env.sh

# Temp helper files
TempList=$(mktemp)
App32=$(mktemp)
App64=$(mktemp)
AppTitle=$(mktemp)
AppType=$(mktemp)
AppArch=$(mktemp)

# Delete TempFiles on exit
CleanExit () {
	rm -f "$TempList"
	rm -f "$App32"
	rm -f "$App64"
	rm -f "$AppTitle"
	rm -f "$AppType"
	rm -f "$AppArch"
}
trap CleanExit 0 1

# Apps Title for both Templates
jq '.templates[].title' "$pt32" | tr -d '"' > "$App32"
jq '.templates[].title' "$pt64" | tr -d '"' > "$App64"
cat "$App32" "$App64" | sort -u > "$AppTitle"

# Apps Type for both Templates
jq '.templates[].type' "$pt32" | paste -d'|' "$App32" - > "$TempList"
jq '.templates[].type' "$pt64" | paste -d'|' "$App64" - >> "$TempList"
sort -u "$TempList" > "$AppType"

# Create AppList title
{
	echo "# Template List"
	echo
	echo "|App Title|System|Type | Doc |Install Script|Extra Scripts|Youtube Video|"
	echo "|:--------|:----:|:---:|:---:|:------------:|:------------|:-----------:|"
} > "$AppList"

# Generate App Table
while IFS="" read -u 9 -r App || [ -n "$App" ]
do
	# Check System Version
	grep -qE "^$App\$" "$App32" && has32='32'
	grep -qE "^$App\$" "$App64" && has64='64'
	[[ -n "$has32" && -n "$has64" ]] && Arch='32/64 bit' || Arch="$has32$has64 bit"

	# Get App Info
	info=$(jq ".apps[] | select(.Title==\"$App\")" "$appinfo")
	if [ "$info" != "" ] ; then

		# Get Doc from app info
		docID=$(echo "$info" | jq ".DocID")
		if [ "$docID" != "null" ]; then
			doc=$(jq ".docs[] | select(.ID==$docID) | .File" "$appinfo" | tr -d '"')
			doc="[Doc]($Docs$doc)"
		else
			unset doc
		fi

		# Get Script from app info
		scriptID=$(echo "$info" | jq ".ScriptID")
		if [ "$scriptID" != "null" ]; then
			script=$(jq ".tools[] | select(.ID==$scriptID) | .File" "$appinfo" | tr -d '"')
			script="[Script]($Scripts$script)"
		else
			unset script
		fi

		# Get Script from app info
		extraID=$(echo "$info" | jq ".ExtraID")
		if [ "$extraID" != "null" ]; then
			# If only one entry
			if [ "$(echo "$extraID" | wc -l )" == "1" ]; then
				extra=$(jq ".tools[] | select(.ID==$extraID) | .File" "$appinfo" | tr -d '"')
				extra="[$extra]($Extras$extra)"
			
			# If multiples entries
			else
				n_ext=$(echo "$extraID" | jq '. | length')
				for n in $(seq 0 $(( n_ext - 1 ))); do
					extID=$(echo "$extraID" | jq ".[$n]" | tr -d \")
					ext=$(jq ".tools[] | select(.ID==$extID) | .File" "$appinfo" | tr -d '"')
					if [ "$n" == "0" ]; then
						txt="[$ext]($Extras$ext)"
					else
						txt="$txt<br>[$ext]($Extras$ext)"
					fi
				done
				extra=$txt
			fi
		else
			unset extra
		fi

		# Get Script from app info
		vid=$(echo "$info" | jq ".VideoID")
		if [ "$vid" != "null" ] ; then
			vidURL=$(jq ".youtube[] | select(.ID==$vid) | .URL" "$appinfo" | tr -d \")
			vid="[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=plastic&logo=youtube&logoColor=white)]($vidURL)"
		else
			unset vid
		fi
	
	else
		unset doc script extra vid
	fi

	# Building App Line
	line="|$App|$Arch|$(grep "$App|" "$AppType" | cut -d'|' -f2 )| $doc | $script | $extra | $vid |"

	# Change container type to string (Default to Container when not set)
	line="${line//|1|/|Container|}"
	line="${line//|null|/|Container|}"
	line="${line//|3|/|Stack|}"

	# Add line to List
	echo "$line" >> "$AppList"

	# Unset System variables
	unset has32 has64
done 9< "$AppTitle"
