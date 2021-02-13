#!/bin/bash
# Simple Theme Updating Script
# Usage :
#   Replace the REP_URL by the correct one for your theme.


REP_URL="https://github.com/Jetup13/es-theme-minimal-arkos/archive/master.zip"
#extract the branch name from the provided URL
REP_BRANCH=$(grep -oP "[^\/]+(?=\.zip)" <<< "$REP_URL")
#extract the repository name from the provided URL
REP_NAME=$(grep -oP "[^\/]+(?=\/archive)" <<< "$REP_URL")
REP_DIR=$REP_NAME-$REP_BRANCH
ABS_PATH=$(readlink -f "$0")
ABS_DIR=$(dirname "$ABS_PATH")
cd "$ABS_DIR"

sudo sh -c 'printf "\033c" > /dev/tty1'
printf "\nStarting update of $REP_NAME..."
mkdir -p /dev/shm/theme_update_temp #create a temp folder in RAM

printf "\nDownloading archive for the $REP_BRANCH branch...\n"
sudo wget -q "$REP_URL" -O /dev/shm/theme_update_temp/update.zip
if unzip -qt /dev/shm/theme_update_temp/update.zip | grep 'No errors detected';then
    printf "\nUnzipping archive..."
    sudo unzip -qo /dev/shm/theme_update_temp/update.zip -d /dev/shm/theme_update_temp/ #unzip directly in RAM
    printf "\nOverwritting existing files..."
    rm *.sh #removing previous scripts, remove this line if you're not the repository maintainer.
    THEME_CONTENT=/dev/shm/theme_update_temp/$REP_DIR/*
    cp -rf $THEME_CONTENT ./
    sudo chmod 777 ./*.sh #make sure newly downloaded scripts have right permission
    printf "\nTheme $REP_NAME updated successfully."
    sleep 3
else
    printf "\nTheme update have failed because the archive did not download correctly."
    printf "\nCheck your connection and try again.\n"
    sleep 6
fi
printf "\nDeleting temporary files...\n"
sudo rm -rf /dev/shm/theme_update_temp #remove the temp folder from RAM