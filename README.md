# dotfiles

## Install on new system

```
sudo apt install -y zsh

# install nvim via appimage https://gist.github.com/opchav/5ba865c9e6415c2af825bad153f876f7

# install oh-my-zsh https://github.com/ohmyzsh/ohmyzsh#basic-installation

# install the nerd font Hack (includes symbols) for the terminal https://www.nerdfonts.com/font-downloads
# install Plug for vim https://github.com/junegunn/vim-plug#unix
# then in nvim type command `:PlugInstall` to install all plugins
# and `:LspInstall <langauge>` to install desired language servers

git clone git://github.com/pogopaule/dotfiles.git
cd dotfiles
./create_links.sh

sudo apt install -y fd-find
sudo apt install -y bat
sudo apt install -y fzf
sudo apt install -y ripgrep
```

## Install new vim plugin

1. Add to init.vim
2. Run `:PlugInstall` in nvim

## Update vim plugins

Run `:PlugUpdate` in nvim
