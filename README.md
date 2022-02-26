# dotfiles

## Install on new system

```
# install terminal alacritty
# install Hack Nerd Font

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

sudo apt install -y fd-find # better find
sudo apt install -y bat # better cat
sudo apt install -y fzf # better ctrl+r
sudo apt install -y ripgrep
sudo apt install -y ncdu # better du
sudo apt install -y tldr # simplified man
sudo apt install -y lnav # log viewer
sudo apt install -y exa # better ls
# install diff-so-fancy https://github.com/so-fancy/diff-so-fancy#install
pip install glances # better top/htop


sudo apt install -y tmux
# install tpm (tmux plugin manager) https://github.com/tmux-plugins/tpm#installation
# install tmux plugins https://github.com/tmux-plugins/tpm#installing-plugins
# install tmuxinator https://github.com/tmuxinator/tmuxinator#installation

# install starship https://starship.rs/guide/#%F0%9F%9A%80-installation
```
