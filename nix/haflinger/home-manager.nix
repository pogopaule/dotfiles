{ pkgs, pkgs-unstable, devenv, ... }:

{
  imports = [
    (import ../common/home-manager.nix { inherit pkgs pkgs-unstable devenv; })
  ];

  home = {
    packages = with pkgs; [
      meld
      discord
      jetbrains.pycharm-community
      git-lfs
    ] ++ [
      devenv.packages.aarch64-darwin.devenv
    ];
  };

  programs = {
    zsh.shellAliases = {
      "-g Y" = "| pbcopy";
    };
    tmux.plugins = [
      {
        plugin = pkgs.tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-command 'echo -n {} | pbcopy'
          set -g @thumbs-regexp-1 '\w+://[^\s]+' # Match URLs
        '';
      }
    ];
    ssh = {
      matchBlocks = {
        "github.com" = {
          identityFile = "/Users/fabian/.ssh/github";
        };
        "gitlab.com" = {
          identityFile = "/Users/fabian/.ssh/gitlab";
        };
      };
    };
  };

  fonts.fontconfig.enable = true; # for Nerdfont
}
