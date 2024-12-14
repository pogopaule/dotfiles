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
      dua
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
      jwt-cli
      mob # mob programming helper
      difftastic
      pre-commit
    ] ++ [
      pkgs-unstable.neovim
      pkgs-unstable.nodePackages."@githubnext/github-copilot-cli"
      pkgs-unstable.eza
      pkgs-unstable.ast-grep
      pkgs-unstable.sq # data wrangling tool
      pkgs-unstable.ruff-lsp
      pkgs-unstable.pyright
      pkgs-unstable.uv
      pkgs-unstable.devbox
      pkgs-unstable.pgcli
      pkgs-unstable.poetry
      pkgs-unstable.visidata
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

    # tool version manager, e.g. for python 3.8 which is not supported by nixpkgs anymore
    mise = {
      enable = true;
      enableZshIntegration = true;
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
      addKeysToAgent = "yes";
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
      settings ={
        format = ''
''$fill
''$all''$character
        '';
        fill = {
          symbol = "─";
          style = "green";
        };
      };
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        -- Theme code taken from https://wezfurlong.org/wezterm/config/lua/wezterm.gui/get_appearance.html
        local wezterm = require 'wezterm'

        -- wezterm.gui is not available to the mux server, so take care to
        -- do something reasonable when this config is evaluated by the mux
        function get_appearance()
          if wezterm.gui then
            return wezterm.gui.get_appearance()
          end
          return 'Dark'
        end

        function scheme_for_appearance(appearance)
          if appearance:find 'Dark' then
            return 'nordfox'
          else
            return 'dawnfox'
          end
        end

        local theme = scheme_for_appearance(get_appearance())

        local theme_file = os.getenv('HOME') .. '/.theme'
        local handle = io.open(theme_file, 'w')
        if get_appearance():find 'Dark' then
          handle:write('dark')
        else
          handle:write('light')
        end
        handle:close()

        return {
          hide_tab_bar_if_only_one_tab = true,
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
            { -- delete word mac
              key = 'Backspace',
              mods = 'ALT',
              action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' },
            },
            { -- delete word linux
              key = 'Backspace',
              mods = 'CTRL',
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
