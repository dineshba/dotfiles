#!/usr/bin/env bash

SOURCE=$( dirname -- "${BASH_SOURCE[0]}" )

# bash config
ln -s $HOME/$SOURCE/.bashrc $HOME/.bashrc
ln -s $HOME/$SOURCE/.bash_profile $HOME/.bash_profile

# alacritty
ln -s $HOME/$SOURCE/alacritty.yml $HOME/.alacritty.yml

# tmux
git clone https://github.com/gpakosz/.tmux.git $SOURCE/.tmux
ln -s $HOME/$SOURCE/.tmux/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/$SOURCE/tmux.conf.local $HOME/.tmux.conf.local

# starship
ln -s $HOME/$SOURCE/starship.toml $HOME/.config/starship.toml

# vim
ln -s $HOME/$SOURCE/vimrc $HOME/.vimrc

# install fira code
# https://github.com/tonsky/FiraCode/wiki/Installing