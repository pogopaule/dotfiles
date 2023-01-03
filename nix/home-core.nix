{ pkgs, pkgs-master, darkTheme, devenv, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ../tmux { inherit pkgs darkTheme; })
    (import ../zsh { inherit pkgs darkTheme; })
  ];

  home = {
    stateVersion = "22.11";
    username = "pogopaule";
    homeDirectory = "/home/pogopaule";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      tldr
      httpie
      ripgrep
      ncdu
      fd
      sd
      duf
      lnav
      cloc
      gcc
      xclip
      curl
      unzip
      git-crypt
      python3
      nodejs
      lazydocker
      docker-compose
      entr
      pv

      sumneko-lua-language-server
      rnix-lsp
      nodePackages.yaml-language-server
      nodePackages.eslint_d
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint_d
      python310Packages.python-lsp-server
    ] ++ [
      pkgs-master.neovim
      devenv.packages.x86_64-linux.devenv
    ];
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;
    bat.enable = true;
    exa.enable = true;
    zoxide.enable = true;
    jq.enable = true;
    gh.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    gpg = {
      enable = true;
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "/home/pogopaule/.ssh/github";
        };
        "gitlab.com" = {
          hostname = "gitlab.com";
          user = "git";
          identityFile = "/home/pogopaule/.ssh/gitlab";
        };
      };
      extraConfig = "AddKeysToAgent yes";
    };

    fzf = rec {
      enable = true;
      changeDirWidgetCommand = "fd --type d --hidden --follow --no-ignore --exclude .git";
      defaultCommand = "fd --type f --hidden --follow --no-ignore --exclude .git";
      fileWidgetCommand = defaultCommand;
      defaultOptions =
        if darkTheme then [ "--color dark" ]
        else [ "--color light" ];
    };

    git = {
      enable = true;
      diff-so-fancy.enable = true;
      includes = [{ path = "~/.gitconfig.local"; }];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
