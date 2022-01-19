# dotfiles

## Install on new system

```
sudo apt install -y zsh

# install oh-my-zsh https://github.com/ohmyzsh/ohmyzsh#basic-installation

# install Plug for vim https://github.com/junegunn/vim-plug#unix
# then in vim type command `:PlugInstall`

git clone git://github.com/pogopaule/dotfiles.git
cd dotfiles
./create_links.sh

sudo apt install -y fd-find
sudo apt install -y bat
sudo apt install -y fzf
```

## Install new vim plugin

1. Add to vimrc
2. Run `:PlugInstall` in vim

## Update vim plugins

Run `:PlugUpdate` in vim
