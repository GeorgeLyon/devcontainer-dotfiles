#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEBIAN_FRONTEND="noninteractive" \
  apt-get install -y \
    zsh git

git clone \
  https://github.com/zsh-users/zsh-autosuggestions \
  ~/.zsh/zsh-autosuggestions

cp -R "$SCRIPT_DIR/zshrc" ~/.zshrc

mkdir -p ~/.ssh
cat << EOF > ~/.ssh/config
Host gh github github.com
 User git
 HostName github.com

Host gl gitlab gitlab.com
 User git
 HostName gitlab.com
EOF
