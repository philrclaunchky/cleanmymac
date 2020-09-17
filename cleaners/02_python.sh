#!/bin/sh

# Check if Anaconda is installed and upgrade packages
if hash pip 2>/dev/null; then

  echo "Updating Python3 packages"
  echo "=========================="
  pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  echo ""

  echo "Clearing Python3 Cache"
  echo "=========================="
  rm -rfv ~/Library/Caches/pip
  echo ""

fi

if [ "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
    echo 'Removing Pyenv-VirtualEnv Cache...'
    rm -rfv $PYENV_VIRTUALENV_CACHE_PATH &>/dev/null
fi
