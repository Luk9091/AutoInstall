#! /usr/bin/bash

backup="${PWD}/backup"
zsh_file="/home/${USER}/.config/zsh"

mkdir -p ${backup}

cp -R ~/.config/tex ${backup}
cp -R ~/.config/nvim ${backup}

mkdir -p ${backup}/zsh
eval cp "${zsh_file}/*.zsh" ${backup}/zsh/
eval cp "${zsh_file}/*.sh"  ${backup}/zsh/

cp ~/.tmux.conf ${backup}/tmux.conf
cp ~/.zshrc ${backup}/zshrc
