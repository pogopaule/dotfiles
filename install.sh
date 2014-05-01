#! /bin/bash

ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vim ~/.vim
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/gitignore_global ~/.gitignore_global
ln -s $PWD/bash_profile ~/.bash_profile

cd ~/.vim
git submodule init
git submodule update

