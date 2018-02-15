#!/bin/sh

read -p "Initialize vim configuration?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/.vimrc $HOME/.vimrc
fi

read -p "Initialize neovim configuration?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mkdir -p $HOME/.config/nvim/
    ln -s $PWD/.vimrc $HOME/.config/nvim/init.vim
fi

read -p "Initialize tmux configuration?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/.tmux.conf $HOME/.tmux.conf
    ln -s $PWD/.tmux-status.conf $HOME/.tmux-status.conf
fi

read -p "Install tmux plugin manager?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

