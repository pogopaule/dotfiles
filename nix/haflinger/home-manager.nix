{ pkgs, pkgs-master, darkTheme, devenv, ... }:

{
  imports = [
    (import ../common/home-manager.nix { inherit pkgs pkgs-master darkTheme devenv; })
  ];

  home = {
    packages = with pkgs; [
      meld
      discord
      jetbrains.pycharm-community
      git-lfs
      magic-wormhole
      azure-cli
    ] ++ [
      devenv.packages.aarch64-darwin.devenv
    ];
  };

  programs = {
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
