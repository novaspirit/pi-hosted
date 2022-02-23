#!/bin/bash

# Portainer Templates
appsfolder="${homedir}template/apps"
pt32="${homedir}template/portainer-v2-arm32.json"
pt64="${homedir}template/portainer-v2-arm64.json"

# README Files with templates
README="${homedir}docs/README.md"
README_TEMPLATE="${homedir}build/templates/template_README.md"
TOOLSREADME="${homedir}tools/README.md"
TOOLSREADME_TEMPLATE="${homedir}build/templates/template_tools_README.md"

# Lists Documents
AppList="${homedir}docs/AppList.md"
AppList_TEMPLATE="${homedir}build/templates/template_AppList.md"
DocList="${homedir}docs/DocumentList.md"
DocList_TEMPLATE="${homedir}build/templates/template_DocumentList.md"

# appinfo file
appinfo="${homedir}build/info.json"

# Internal folders
Scripts="../tools/"
Extras="../tools/"
Docs="../docs/"

# Verification file
verificationFile="${homedir}build/tmp/lastrun.sha256"
