dotfiles
========

Windows
========

git clone git://github.com/pogopaule/dotfiles.git<br/>
cd dotfiles<br/>
git submodule init<br/>
git submodule update<br/>

xcopy %CD%\vim %HOMEPATH%\vimfiles /s /i<br/>
copy %CD%\vimrc %HOMEPATH%\_vimrc<br/>

Mac
========

git clone git://github.com/pogopaule/dotfiles.git<br/>
cd dotfiles<br/>
./install.sh<br/>

Install new vim plugin
========
cd dotfiles/vim/bundle/
git submodule add git://github.com/mustache/vim-mustache-handlebars.git
