#!/bin/bash

# Portainer Templates
appsfolder="template/apps"
pt32="template/portainer-v2-arm32.json"
pt64="template/portainer-v2-arm64.json"

# README Files with templates
README="docs/README.md"
README_TEMPLATE="build/templates/template_README.md"
TOOLSREADME="tools/README.md"
TOOLSREADME_TEMPLATE="build/templates/template_tools_README.md"

# Lists Documents
AppList="docs/AppList.md"
AppList_TEMPLATE="build/templates/template_AppList.md"
DocList="docs/DocumentList.md"
DocList_TEMPLATE="build/templates/template_DocumentList.md"

# appinfo file
appinfo="${homedir}build/info.json"

# Internal folders
Scripts="../tools/"
Extras="../tools/"
Docs="../docs/"

# Verification file
verificationFile="build/tmp/lastrun.sha256"
