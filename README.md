# dotfiles

## Install on new NixOS system

- download plasma iso
- use etcher to create bootable usb stick
- boot from usb stick
- use wizard and select Plasma and encrypted disk as well as swap+hibernate
- now on the freshly installed nixos
- `nix shell nixpkgs#git --extra-experimental-features 'nix-command flakes'`
- `git clone https://github.com/pogopaule/dotfiles.git` into home folder
- Use KWrite to copy UUIDs from
  - /etc/nixos/hardware-configuration.nix to ~/dotfiles/nix/hardware-configuration.nix
  - /etc/nixos/configuration.nix to ~/dotfiles/nix/configuration.nix
- `./link_nvim_config.sh`
- `./apply-panther.sh`
- reboot
- login to firefox, syncs plugins and bookmarks
- rsync example for the following steps: rsync -avP --exclude=node_modules --exclude=target 192.168.0.1:~/foo/ ~/foo
- create new keys for github and gitlab or rsync them from old machine
- setup ~/.gitconfig.local with user.name and user.email
- checkout scripts von gitlab or rsync from old machine
- checkout zettelkasten von gitlab or rsync from old machine
- restore Documents or rsync from old machine
- log into various tools

## Install on a new Mac system

- https://nixos.org/download.html#nix-install-macos
- Install homebrew (will be controlled by nix)
- `nix shell nixpkgs#git --extra-experimental-features 'nix-command flakes'`
- `git clone https://github.com/pogopaule/dotfiles.git` into home folder
- `nix build .#darwinConfigurations.haflinger.system --extra-experimental-features 'nix-command flakes'`
- `./result/sw/bin/darwin-rebuild switch --flake .#haflinger` and follow instrunctions for symlink error
- If there are errors: `sudo rm /etc/nix/nix.conf /etc/shells`
- Change some keymaps in System Settings to use Ctrl instead of Meta key
- ```
  curl -O https://raw.githubusercontent.com/xv0x7c0/osx-us-altgr-intl/master/us-altgr-intl.keylayout
   sudo mv us-altgr-intl.keylayout /Library/Keyboard\ Layouts
```
- `ln -s $PWD/amethyst.yml ~/.amathyst.yml`
