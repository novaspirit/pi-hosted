#!/bin/bash

# Portainer Templates
pt32="${homedir}template/portainer-v2-arm32.json"
pt64="${homedir}template/portainer-v2-arm64.json"

# README Files with templates
README="${homedir}docs/README.md"
README_TEMPLATE="${homedir}build/template_README.md"
TOOLSREADME="${homedir}tools/README.md"
TOOLSREADME_TEMPLATE="${homedir}build/template_tools_README.md"

# Lists Documents
AppList="${homedir}docs/AppList.md"
AppList_TEMPLATE="${homedir}build/template_AppList.md"
DocList="${homedir}docs/DocumentList.md"
DocList_TEMPLATE="${homedir}build/template_DocumentList.md"

# appinfo file
appinfo="${homedir}build/appinfo.json"

# Internal folders
Scripts="${homedir}tools/"
Extras="${homedir}tools/"
Docs="${homedir}docs/"

# Verification file
verificationFile="${homedir}build/lastrun.sha256"
