#! /bin/bash

ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/gitignore_global ~/.gitignore_global
ln -s $PWD/tmux/tmux.conf ~/.tmux.conf
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/nvim ~/.config/nvim
ln -s $PWD/alacritty/alacritty.yml ~/.alacritty.yml

mkdir -p ~/.config/lazygit
ln -s $PWD/lazygit.yml ~/.config/lazygit/config.yml
