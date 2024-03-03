{ pkgs, pkgs-master, devenv, ... }:

{
  imports = [
    (import ../common/home-manager.nix { inherit pkgs pkgs-master devenv; })
  ];

  home = {
    username = "pogopaule";
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      signal-desktop
      thunderbird
      libreoffice
      pcloud
      keepassxc
      spotify
      libimobiledevice
      ifuse
      vlc
      xclip
      meld
      nethogs
    ] ++ [
      pkgs-master.uhk-agent
      devenv.packages.x86_64-linux.devenv
      pkgs-master.obsidian
    ];
  };

  programs = {
    zsh.shellAliases = {
      "-g Y" = "| xclip -selection clip";
    };
    tmux.plugins = [
      {
        plugin = pkgs.tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-command 'echo -n {} | xclip -selection clipboard'
          set -g @thumbs-regexp-1 '\w+://[^\s]+' # Match URLs
        '';
      }
    ];
    firefox.enable = true;
    chromium.enable = true;
    ssh = {
      matchBlocks = {
        "github.com" = {
          identityFile = "/home/pogopaule/.ssh/github";
        };
        "gitlab.com" = {
          identityFile = "/home/pogopaule/.ssh/gitlab";
        };
      };
    };
    gpg = {
      enable = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
}
