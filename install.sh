#!/bin/bash

read -p "Initialize Alacritty?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mkdir -p $HOME/.config/alacritty/
    ln -s $PWD/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi

read -p "Initialize zsh?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf $HOME/.zprezto/runcoms
    ln -s $PWD/runcoms $HOME/.zprezto/runcoms
fi

read -p "Initialize git?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/git/gitconfig $HOME/.gitconfig
fi

read -p "Initialize Tig?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/tig/tigrc $HOME/.tigrc
fi

read -p "Initialize vim configuration?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/vim/vimrc $HOME/.vimrc
fi

read -p "Initialize vim-plug?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

read -p "Initialize neovim configuration?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mkdir -p $HOME/.config/nvim/
    ln -s $PWD/vim/vimrc $HOME/.config/nvim/init.vim
fi

read -p "Initialize tmux configuration?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -s $PWD/tmux/tmux-status.conf $HOME/.tmux-status.conf
fi

read -p "Install tmux plugin manager?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

read -p "Initialize VSCode?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    [[ -f $HOME/Library/Application\ Support/Code/User/settings.json ]] && rm $HOME/Library/Application\ Support/Code/User/settings.json
    ln -s $PWD/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

    [[ -f $HOME/Library/Application\ Support/Code/User/keybindings.json ]] && rm $HOME/Library/Application\ Support/Code/User/keybindings.json
    ln -s $PWD/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

    cat $PWD/vscode/extensions | xargs -L 1 code --install-extension
fi

read -p "Initialize vifm?" -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -s $PWD/vifm $HOME/.vifm
fi
