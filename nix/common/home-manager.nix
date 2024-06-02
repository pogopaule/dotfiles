{ pkgs, pkgs-unstable, devenv, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ../../tmux { inherit pkgs; })
    (import ../../zsh { inherit pkgs; })
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
      tokei # count lines of code
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
      pgcli
      hyperfine # benchmarking
      glow # markdown viewer
      hexyl # hex viewer
      croc # transfer files
      fx # json viewer
      gron # flatten json to make it greppable
      git-extras # git utilities
      noti # banner notifications
      viddy # modern watch
      lychee # link checker
      kopia # backup tool
      rclone
      d2 # data to diagrams
      hurl # http with plain text
      cachix

      sumneko-lua-language-server
      nodePackages.yaml-language-server
      nodePackages.eslint_d
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
    ] ++ [
      pkgs-unstable.neovim
      pkgs-unstable.nodePackages."@githubnext/github-copilot-cli"
      pkgs-unstable.eza
      pkgs-unstable.ast-grep
      pkgs-unstable.sq # data wrangling tool
      pkgs-unstable.ruff-lsp
      pkgs-unstable.nodePackages.pyright
    ];
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;
    bat.enable = true;
    zoxide.enable = true;
    jq.enable = true;
    gh = {
      enable = true;
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
    };

    git = {
      enable = true;
      difftastic.enable = true;
      includes = [{ path = "~/.gitconfig.local"; }];
      extraConfig = {
        core.editor = "nvim";
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
      package = pkgs-unstable.wezterm;
      extraConfig = ''
        local theme = 'dawnfox'


        local handle = io.open(os.getenv('HOME') .. '/.theme', 'r')
        local result = handle:read("*a")
        handle:close()
        result = string.gsub(result, "\n", "")
        if result == 'dark' then
          theme = 'nordfox'
        end

        return {
          hide_tab_bar_if_only_one_tab = true,
          default_prog = { "zsh", "--login", "-c", "tmux attach -t default || tmux new -s default" },
          font_size = 18.0,
          font = wezterm.font('Iosevka Nerd Font'),
          hide_mouse_cursor_when_typing = false,
          color_scheme = theme,
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
              key = 't',
              mods = 'SUPER',
              action = wezterm.action.DisableDefaultAssignment,
            },
            {
              key = 'Tab',
              mods = 'CTRL',
              action = wezterm.action.DisableDefaultAssignment,
            },
            {
              key = 'Tab',
              mods = 'CTRL|SHIFT',
              action = wezterm.action.DisableDefaultAssignment,
            },
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
            },
            {
              key = 'w',
              mods = 'CMD',
              action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' },
            },
            {
              key = 'Backspace',
              mods = 'ALT',
              action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' },
            }
          }
        }
      '';
    };

    vscode = {
      enable = true;
      package = pkgs-unstable.vscode;
    };
  };

  fonts.fontconfig.enable = true; # for Nerdfont
}
