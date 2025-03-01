{ pkgs, pkgs-unstable, devenv, ... }:

{
  imports = [
    (import ../common/home-manager.nix { inherit pkgs pkgs-unstable devenv; })
  ];

  home = {
    packages = with pkgs; [
      meld
      git-lfs
      kubelogin
    ] ++ [
      devenv.packages.aarch64-darwin.devenv
    ];
  };

  programs = {
    k9s = {
      enable = true;
      settings = {
        k9s = {
          ui.skin = "solarized_light";
        };
      };
    };
    zsh = {
      shellGlobalAliases = {
        Y = "| pbcopy";
      };
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
