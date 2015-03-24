#!/bin/sh
CONFIG_HOME=$HOME/.mac-config

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

[ -e $CONFIG_HOME ] && die "$CONFIG_HOME already exists."

git clone https://github.com/xfalcons/mac-config.git "$CONFIG_HOME"

cd ~
[ ! -d "bin" ] && mkdir -p bin
[ ! -d "mac-config.bak" ] && mkdir -p mac-config.bak

target_files=".bash_profile .bashrc .gemrc .tmux.conf .gitconfig .gitexcludes .gitignore_global bin/git_differ_wrapper"
for f in $target_files
do
    if [ -e $f ]
    then
        mv $f mac-config.bak/
        echo "Move $f to mac-config.bak/"
    fi
done

ln -s .mac-config/bash_profile .bash_profile
ln -s .mac-config/bashrc .bashrc
ln -s .mac-config/gemrc .gemrc
ln -s .mac-config/tmux.conf .tmux.conf
ln -s .mac-config/gitconfig .gitconfig
ln -s .mac-config/gitexcludes .gitexcludes
ln -s .mac-config/gitignore_global .gitignore_global
ln -s .mac-config/bin/git_diff_wrapper bin/git_diff_wrapper

# wget -O - https://raw.github.com/xfalcons/vimrc/master/auto-install.sh | sh

echo "$HOME configuration file has been installed."
