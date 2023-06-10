{ pkgs, pkgs-master, darkTheme, devenv, ... }:

{
  imports = [
    (import ../common/home-manager.nix { inherit pkgs pkgs-master darkTheme devenv; })
  ];

  home = {
    username = "pogopaule";
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      signal-desktop
      thunderbird
      todoist-electron
      libreoffice
      pcloud
      keepassxc
      spotify
      libimobiledevice
      ifuse
      vlc
      xclip
      meld
    ] ++ [
      pkgs-master.uhk-agent
      devenv.packages.x86_64-linux.devenv
    ];
  };

  programs = {
    tmux.plugins = [
      {
        plugin = pkgs.tmuxPlugins.tmux-thumbs;
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
