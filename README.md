#dotfiles

##Windows

`git clone git://github.com/pogopaule/dotfiles.git`<br/>
`cd dotfiles`<br/>
`install.bat`<br/>

##Mac

`git clone git://github.com/pogopaule/dotfiles.git; cd dotfiles; ./install.sh`

##Install new vim plugin

`git submodule add git://github.com/mustache/vim-mustache-handlebars.git vim/bundle/vim-mustache-handlebars`

On the other machines then do: `git submodule update --init --recursive`

##Update vim plugins

`git submodule foreach git pull origin master`
