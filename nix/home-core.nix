{ pkgs, pkgs-master, darkTheme, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ../tmux { inherit pkgs darkTheme; })
    (import ../zsh { inherit pkgs darkTheme; })
  ];

  home = {
    stateVersion = "22.05";
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
      git-secret

      sumneko-lua-language-server
      rnix-lsp
      nodePackages.yaml-language-server
      python310Packages.python-lsp-server
    ] ++ [ pkgs-master.neovim ];
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

    gpg = {
      enable = true;
    };

    ssh = {
      enable = true;
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
