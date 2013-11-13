dotfiles
========

Windows
========

git clone git://github.com/pogopaule/dotfiles.git C:\Users\%HOMEPATH%\dotfiles<br/>
mklink /H %HOMEPATH%_vimrc %HOMEPATH%\dotfiles\vimrc<br/>
mklink /J %HOMEPATH%\vimfiles %HOMEPATH%\dotfiles\vim<br/>
mklink /J %HOMEPATH%.gitconfig %HOMEPATH%\dotfiles\gitconfig<br/>
mklink /J %HOMEPATH%.gitignore_global %HOMEPATH%\dotfiles.gitignore_global<br/>

Mac
========

git clone git://github.com/pogopaule/dotfiles.git<br/>
cd dotfiles
./install.sh
