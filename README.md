# dotfiles

## Install on new system

- [alacritty](https://github.com/alacritty/alacritty#installation) 
- [brew](https://brew.sh/)
- `brew bundle Brewfile`
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [hack nerd font](https://www.nerdfonts.com/font-downloads)

```
cd ~
git clone git://github.com/pogopaule/dotfiles.git
cd dotfiles
./create_links.sh
```

- [tpm](https://github.com/tmux-plugins/tpm#installation)
- run `tmux` and press `ctrl-a I` to install tmux plugins
- install `tmuxinator-fzf-start` with `wget --output-document ~/.local/bin/tmuxinator-fzf-start.sh https://raw.githubusercontent.com/camspiers/tmuxinator-fzf-start/f1e7200df793da093f2b04f732e1554453940074/tmuxinator-fzf-start.sh && chmod +x ~/.local/bin/tmuxinator-fzf-start.sh`
- [fzf-tab](https://github.com/Aloxaf/fzf-tab#oh-my-zsh) 
- `:LspInstall <langauge>` to install desired language servers inside vim
