{ pkgs, pkgs-master, darkTheme, devenv, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ../../tmux { inherit pkgs darkTheme; })
    (import ../../zsh { inherit pkgs darkTheme; })
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
    gh = {
      enable = true;
      extensions = [
        pkgs-master.gh-dash
      ];
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
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

    wezterm = {
      enable = true;
      package = pkgs-master.wezterm;
      extraConfig = ''
        return {
          hide_tab_bar_if_only_one_tab = true,
          default_prog = { "zsh", "--login", "-c", "tmux attach -t default || tmux new -s default" },
          font_size = 18.0,
          font = wezterm.font('Iosevka Nerd Font'),
          color_scheme = ${ if darkTheme then "'nordfox'" else "'dawnfox'" },
          colors = {
            cursor_bg = '#ff00ff',
            cursor_fg = '#ffffff',
          },
          window_padding = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0,
          },
          audible_bell = 'Disabled',
          warn_about_missing_glyphs = false,
          keys = {
            {
              key = 'Enter',
              mods = 'ALT',
              action = wezterm.action.DisableDefaultAssignment,
            },
            {
              key = 'PageUp',
              mods = 'CTRL',
              action = wezterm.action.DisableDefaultAssignment,
            },
            {
              key = 'PageDown',
              mods = 'CTRL',
              action = wezterm.action.DisableDefaultAssignment,
            }
          }
        }
      '';
    };

    vscode = {
      enable = true;
      package = pkgs-master.vscode;
    };
  };

  fonts.fontconfig.enable = true; # for Nerdfont
}
