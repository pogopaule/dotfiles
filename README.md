dotfiles
========

Windows
========

git clone git://github.com/pogopaule/dotfiles.git C:\Users\%HOMEPATH%\dotfiles
mklink /H %HOMEPATH%_vimrc %HOMEPATH%\dotfiles\vimrc
mklink /J %HOMEPATH%\vimfiles %HOMEPATH%\dotfiles\vim
mklink /J %HOMEPATH%.gitconfig %HOMEPATH%\dotfiles\gitconfig
mklink /J %HOMEPATH%.gitignore_global %HOMEPATH%\dotfiles.gitignore_global

Mac
========

git clone git://github.com/pogopaule/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
