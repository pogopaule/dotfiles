# dotfiles

## Install on new system

- `sudo apt install -y git curl gcc gnome-tweaks zsh` `gnome-tweaks` to map caps-lock to ctrl
- `git clone git://github.com/pogopaule/dotfiles.git ~/dotfiles`
- [alacritty](https://github.com/alacritty/alacritty#installation) 
- [brew](https://brew.sh/) ([on linux](https://docs.brew.sh/Homebrew-on-Linux))
- `brew bundle install --file=Brewfile`
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [hack nerd font](https://www.nerdfonts.com/font-downloads) ([how to install](https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0) )
- [fzf-tab](https://github.com/Aloxaf/fzf-tab#oh-my-zsh) 
- `touch ~/.zshrc.local`
- `cd ~/dotfiles && ./create_links.sh`
- [tpm](https://github.com/tmux-plugins/tpm#installation)
- run `tmux` and press `ctrl-a I` to install tmux plugins
- install `tmuxinator-fzf-start` with `wget --output-document ~/.local/bin/tmuxinator-fzf-start.sh https://raw.githubusercontent.com/camspiers/tmuxinator-fzf-start/f1e7200df793da093f2b04f732e1554453940074/tmuxinator-fzf-start.sh && chmod +x ~/.local/bin/tmuxinator-fzf-start.sh`
- `:LspInstall <langauge>` to install desired language servers inside vim
