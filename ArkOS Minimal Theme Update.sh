#!/bin/bash
# Simple Theme Updating Script
# Usage :
#   Replace the REPURL by the correct one for your theme.

REPURL="https://github.com/Jetup13/es-theme-minimal-arkos/archive/master.zip"
#extract the branch name from the provided URL
REPBRANCH=$(grep -oP "[^\/]+(?=\.zip)" <<< "$REPURL")
#extract the repository name from the provided URL
REPNAME=$(grep -oP "[^\/]+(?=\/archive)" <<< "$REPURL")
REPDIR=$REPNAME-$REPBRANCH
ABSPATH=$(readlink -f "$0")
ABSDIR=$(dirname "$ABSPATH")
cd "$ABSDIR"

sudo sh -c 'printf "\033c" > /dev/tty1'
printf "\nStarting update of $REPNAME..."
printf "\nDownloading archive...\n"
sudo wget -q "$REPURL" -O ./update.zip
if unzip -qt update.zip | grep 'No errors detected';then
    printf "\nUnzipping archive..."
    sudo unzip -qo update.zip -d ./temp/
    printf "\nOverwritting existing files..."
    rm *.sh #removing previous scripts
    temppath=./temp/$REPDIR/*
    cp -rf $temppath ./
    printf "\nDeleting temporary files..."
    sudo rm -rf temp
    printf "\nTheme $REPNAME updated successfully."
    sleep 3
else
    printf "\nTheme update have failed because the archive did not download correctly."
    printf "\nCheck your connection and try again.\n"
    sleep 6
fi
sudo rm update.zip