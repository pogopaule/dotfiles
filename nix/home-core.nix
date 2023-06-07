{ pkgs, pkgs-master, darkTheme, devenv, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ../tmux { inherit pkgs darkTheme; })
    (import ../zsh { inherit pkgs darkTheme; })
  ];

  home = {
    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      tealdeer # tldr
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
      zip
      unzip
      git-crypt
      python3
      nodejs
      lazydocker
      docker-compose
      entr # watch files
      pv # monitor progress in pipes
      yq # jq for yaml
      ijq # interactive jq
      gnumake
      exiftool
      # nethogs # monitor network traffic TODO: only linux
      pgcli
      hyperfine # benchmarking
      glow # markdown viewer
      hexyl # hex viewer

      sumneko-lua-language-server
      rnix-lsp
      nodePackages.yaml-language-server
      nodePackages.eslint_d
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
    ] ++ [
      pkgs-master.neovim
      pkgs-master.nodePackages."@githubnext/github-copilot-cli"
    ];
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
      settings.use-agent = false;
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
        };
        "gitlab.com" = {
          hostname = "gitlab.com";
          user = "git";
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
