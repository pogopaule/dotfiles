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
      tealdeer  # tldr
      httpie
      ripgrep
      ncdu
      fd
      sd # find/replace
      duf # disk usage
      lnav
      cloc # count lines of code
      gcc
      curl
      unzip
      git-crypt
      python3
      nodejs
      lazydocker
      docker-compose
      entr # watch files
      pv # monitor progress in pipes
      yq  # jq for yaml
      ijq # interactive jq
      gnumake
      exiftool
      nethogs # monitor network traffic
      pgcli
      hyperfine # benchmarking
      glow # markdown viewer

      sumneko-lua-language-server
      rnix-lsp
      nodePackages.yaml-language-server
      nodePackages.eslint_d
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint_d
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
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d --hidden --follow --no-ignore --exclude .git";
      defaultCommand = "fd --type f --hidden --follow --no-ignore --exclude .git";
      fileWidgetCommand = defaultCommand;
      historyWidgetOptions = [ "--reverse" ];
      defaultOptions =
        if darkTheme then [ "--color dark" ]
        else [ "--color light" ];
    };

    git = {
      enable = true;
      diff-so-fancy.enable = true;
      includes = [{ path = "~/.gitconfig.local"; }];
      extraConfig = {
        push = {
          autoSetupRemote = true;
        };
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
