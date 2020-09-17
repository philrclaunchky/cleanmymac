#!/bin/bash

# Ask for the administrator password upfront
sudo -v

HOST=$( whoami )

# Keep-alive sudo until `clenaup.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

oldAvailable=$(df / | tail -1 | awk '{print $4}')

echo 'Empty the Trash on all mounted volumes and the main HDD...'
sudo rm -rfv /Volumes/*/.Trashes/* &>/dev/null
sudo rm -rfv ~/.Trash/* &>/dev/null

echo 'Clear System Log Files...'
sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null

echo 'Clear Adobe Cache Files...'
sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

echo 'Cleanup iOS Applications...'
rm -rfv ~/Music/iTunes/iTunes\ Media/Mobile\ Applications/* &>/dev/null

echo 'Remove iOS Device Backups...'
rm -rfv ~/Library/Application\ Support/MobileSync/Backup/* &>/dev/null

echo 'Cleanup XCode Derived Data and Archives...'
rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null

if [ -d "/Users/${HOST}/Library/Caches/CocoaPods" ]; then
    echo 'Cleanup CocoaPods cache...'
    rm -rfv ~/Library/Caches/CocoaPods/* &>/dev/null
fi

# support delete Google Chrome caches
if [ -d "/Users/${HOST}/Library/Caches/Google/Chrome" ]; then
    echo 'Cleanup Google Chrome cache...'
    rm -rfv ~/Library/Caches/Google/Chrome/* &> /dev/null
fi

# support delete Dropbox Cache
if [ -d "/Users/${HOST}/Dropbox" ]; then
echo 'Clear Dropbox 📦 Cache Files...'
sudo rm -rfv ~/Dropbox/.dropbox.cache/* &>/dev/null
fi
