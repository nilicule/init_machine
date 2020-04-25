#!/usr/bin/env bash

# Do all macOS-specific things
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Set macOS defaults - shamelessly ripped from https://github.com/mijndert
  source macos.sh

  # Install all dependencies from Brewfile
  brew update
  brew tap homebrew/bundle
  brew bundle

  # Do python stuff
  ln -s -f /usr/local/bin/pip3 /usr/local/bin/pip
  ln -s -f /usr/local/bin/python3 /usr/local/bin/python
  pip install virtualenv

  # Install shell
  curl -Lo /tmp/install-ohmyzsh.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  sh /tmp/install-ohmyzsh.sh --unattended
  grep -Fxq '/usr/local/bin/zsh' /etc/shells || sudo bash -c "echo /usr/local/bin/zsh >> /etc/shells"
  chsh -s /usr/local/bin/zsh $USER
fi

# Restore backup
rclone/sync.sh sync
