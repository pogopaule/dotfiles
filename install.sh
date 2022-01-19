#! /bin/bash

sudo apt install -y fd-find
sudo apt install -y bat
sudo apt install -y fzf

ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vrapperrc ~/.vrapperrc
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/gitignore_global ~/.gitignore_global
ln -s $PWD/bash_profile ~/.bash_profile
ln -s $PWD/agignore ~/.agignore
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/zshrc ~/.zshrc
