#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

function check_internet() {
  printf "Checking if you are online..."
  wget -q --spider http://github.com
  if [ $? -eq 0 ]; then
    echo "Online. Continuing."
  else
    error "Offline. Go connect to the internet then run the script again."
  fi
}

check_internet

BASE_DIR='/portainer/Files/AppData/Config/invidious'

echo "Creating directories..."
sudo mkdir -p "${BASE_DIR}/config-sql" || error "Failed to create config directory"
sudo mkdir -p "${BASE_DIR}/dbdata" || error "Failed to create data directory for Invidious!"

echo "Downloading Invidious SQL config files"
GH_INVIDIOUS_RAW='https://raw.githubusercontent.com/iv-org/invidious/master'
f='annotations.sql'      ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='channel_videos.sql'   ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='channels.sql'         ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='nonces.sql'           ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='playlist_videos.sql'  ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='playlists.sql'        ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='session_ids.sql'      ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='users.sql'            ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"
f='videos.sql'           ; sudo wget -O "${BASE_DIR}/config-sql/$f" "${GH_INVIDIOUS_RAW}/config/sql/$f" || error "Failed to download $f file!"

echo "Downloading Invidious init script"
f='init-invidious-db.sh' ; sudo wget -O "${BASE_DIR}/$f" "${GH_INVIDIOUS_RAW}/docker/$f"                || error "Failed to download $f file!"
sudo chmod +x "${BASE_DIR}/$f"

echo "Preparation completed, proceed installation in portainer"
echo -e "Suggestion for \\e[1mDB_PASSWORD\\e[39m: \\e[33m$(openssl rand -base64 24)\\e[39m"
