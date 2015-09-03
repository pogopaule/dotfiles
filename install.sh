#! /bin/bash

ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vim ~/.vim
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/gitignore_global ~/.gitignore_global
ln -s $PWD/bash_profile ~/.bash_profile
ln -s $PWD/agignore ~/.agignore
ln -s $PWD/my_custom.zsh ~/.oh-my-zsh/custom/my_custom.zsh
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/zshrc ~/.zshrc

sudo npm install --global instant-markdown-d

git submodule init
git submodule update

