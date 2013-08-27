dotfiles
========

Windows
-------
git clone git://github.com/pogopaule/dotfiles.git C:\Users\%HOMEPATH%\dotfiles 
mklink /H %HOMEPATH%\_vimrc %HOMEPATH%\dotfiles\vimrc
mklink /J %HOMEPATH%\vimfiles %HOMEPATH%\dotfiles\vim

Mac
-------
git clone git://github.com/pogopaule/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
