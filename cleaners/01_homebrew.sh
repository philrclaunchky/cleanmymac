#!/bin/sh

# Check if brew is installed and perform maintainance
if hash brew 2>/dev/null; then

  echo "Performing Homebrew maintainance"
  echo "================================"
  echo ""
  echo "Checking for updates for homebrew..."
  brew update
  brew upgrade
  brew upgrade --cask
  brew outdated --cask | cut -f 1 | xargs brew cask reinstall
  echo ""

  echo "Calling the brewery doctor for the mandatory health checkup..."
  brew doctor
  brew cask doctor
  brew missing
  echo ""

  echo "Cleaning the brewery..."
  brew cleanup -s
  echo ""

fi
