#!/bin/sh

DRIVENAME="gdrive"

if [ "$1" == "backup" ]; then
    ACTION="backup"
elif [ "$1" == "sync" ]; then
    ACTION="sync"
else
    echo
    echo "Usage: $0 [backup|sync]"
    exit;
fi

# AWS configuration files
if [ "$ACTION" == "backup" ]; then
  echo "Copying AWS configuration files"
  rclone copy ~/.aws $DRIVENAME:rclone/aws
elif [ "$ACTION" == "sync" ]; then
  echo "Restoring AWS configuration files"
  rclone sync $DRIVENAME:rclone/aws ~/.aws
fi

# SSH keys
if [ "$ACTION" == "backup" ]; then
  echo "Copying SSH keys"
  rclone copy ~/.ssh $DRIVENAME:rclone/ssh
elif [ "$ACTION" == "sync" ]; then
  echo "Restoring SSH keys"
  rclone sync $DRIVENAME:rclone/ssh ~/.ssh
fi

# Composer auth.json
if [ "$ACTION" == "backup" ]; then
  echo "Copying Composer auth.json"
  rclone copyto ~/.composer/auth.json $DRIVENAME:rclone/composer/auth.json
elif [ "$ACTION" == "sync" ]; then
  echo "Restoring Composer auth.json"
  rclone sync $DRIVENAME:rclone/composer/auth.json ~/.composer/auth.json
fi

# oh-my-zsh custom configuration
if [ "$ACTION" == "backup" ]; then
  echo "Copying oh-my-zsh custom configuration"
  rclone copy ~/.oh-my-zsh/custom $DRIVENAME:rclone/zsh/custom/
elif [ "$ACTION" == "sync" ]; then
  echo "Restoring oh-my-zsh custom configuration"
  rclone sync $DRIVENAME:rclone/zsh/custom ~/.oh-my-zsh/custom
fi

# Dotfiles
if [ "$ACTION" == "backup" ]; then
  echo "Copying .gitconfig"
  rclone copyto ~/.gitconfig $DRIVENAME:rclone/dotfiles/gitconfig
  echo "Copying .arcrc"
  rclone copyto ~/.arcrc $DRIVENAME:rclone/dotfiles/arcrc
  echo "Copying .ansible.cfg"
  rclone copyto ~/.ansible.cfg $DRIVENAME:rclone/dotfiles/ansible.cfg
elif [ "$ACTION" == "sync" ]; then
  echo "Restoring .gitconfig"
  rclone sync $DRIVENAME:rclone/dotfiles/gitconfig ~/.gitconfig
  echo "Restoring .arcrc"
  rclone sync $DRIVENAME:rclone/dotfiles/arcrc ~/.arcrc
  echo "Restoring .ansible.cfg"
  rclone sync $DRIVENAME:rclone/dotfiles/ansible.cfg ~/.ansible.cfg
fi

# Tools
if [ "$ACTION" == "backup" ]; then
  echo "Copying tools"
  rclone copy ~/bin $DRIVENAME:rclone/bin
elif [ "$ACTION" == "sync" ]; then
  echo "Restoring tools"
  rclone sync $DRIVENAME:rclone/bin ~/bin
fi

echo "Done!"