{ config, pkgs, ... }:

let
darkTheme = true;
in
{
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "22.05";
    username = "pogopaule";
    homeDirectory = "/home/pogopaule";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" ]; })
      neovim
      zsh-fzf-tab
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
      gnupg
      curl

      signal-desktop
      thunderbird
      todoist-electron
    ];
  };

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    htop.enable = true;
    bat.enable = true;
    exa.enable = true;
    zoxide.enable = true;
    jq.enable = true;
    gh.enable = true;
    ssh.enable = true;

    fzf = rec {
      enable = true;
      changeDirWidgetCommand = "fd --type d --hidden --follow --no-ignore --exclude .git";
      defaultCommand = "fd --type f --hidden --follow --no-ignore --exclude .git";
      fileWidgetCommand = defaultCommand;
      defaultOptions =
        if darkTheme then [ "--color dark" ]
        else [ "--color light" ];
    };

    alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 13;
          normal.family = "Hack Nerd Font";
          bold.family = "Hack Nerd Font";
          italic.family = "Hack Nerd Font";
          bold_italic.family = "Hack Nerd Font";
        };
        window.startup_mode = "Maximized";
        key_bindings = [
        {
          key = "F11";
          action = "ToggleFullscreen";
        }
        ];
        colors = if darkTheme then {
          primary = {
            background = "0x2e3440";
            foreground = "0xcdcecf";
          };
          normal = {
            black = "0x3b4252";
            red = "0xbf616a";
            green = "0xa3be8c";
            yellow = "0xebcb8b";
            blue = "0x81a1c1";
            magenta = "0xb48ead";
            cyan = "0x88c0d0";
            white = "0xe5e9f0";
          };
          bright = {
            black = "0x465780";
            red = "0xd06f79";
            green = "0xb1d196";
            yellow = "0xf0d399";
            blue = "0x8cafd2";
            magenta = "0xc895bf";
            cyan = "0x93ccdc";
            white = "0xe7ecf4";
          };
          indexed_colors = [
          {
            index = 16;
            color = "0xc9826b";
          }
          {
            index = 17;
            color = "0xbf88bc";
          }
          ];
        }
        else
        {
          primary = {
            background = "0xeaeaea";
            foreground = "0x1d344f";
          };
          normal = {
            black = "0x1d344f";
            red = "0xb95d76";
            green = "0x618774";
            yellow = "0xba793e";
            blue = "0x4d688e";
            magenta = "0x8e6f98";
            cyan = "0x6ca7bd";
            white = "0xcdd1d5";
          };
          bright = {
            black = "0x24476f";
            red = "0xc76882";
            green = "0x629f81";
            yellow = "0xca884a";
            blue = "0x4e75aa";
            magenta = "0x9f75ac";
            cyan = "0x74b2c9";
            white = "0xcfd6dd";
          };
          indexed_colors = [
            {
              index = 16;
              color = "0xe3786c";
            }
            {
              index = 17;
              color = "0xd685af";
            }
          ];
        };
      };
    };

    git = {
      enable = true;
      diff-so-fancy.enable = true;
      includes = [{ path = "~/.gitconfig.local"; }];
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      shortcut = "a";
      baseIndex = 1;
      terminal = "xterm-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      tmuxinator.enable = true;
      plugins = with pkgs.tmuxPlugins; [
        prefix-highlight
        yank
        {
          plugin = yank;
          # https://github.com/tmux-plugins/tmux-yank#linux-clipboards
          extraConfig = "set -g @yank_selection_mouse 'clipboard'";
        }
        {
          plugin = extrakto;
          extraConfig = ''
            set -g @extrakto_popup_size '50%'
            set -g @extrakto_popup_position 'R,C'
            set -g @extrakto_open_tool 'x-www-browser'
            set -g @extrakto_copy_key 'ctrl-c'
            set -g @extrakto_insert_key 'enter'
            set -g @extrakto_filter_order 'line word all'
          '';
        }
      ];
      extraConfig = ''
        # enable mouse
        set -g mouse on

        # refresh 'status-left' and 'status-right' more often, default is 15
        set -g status-interval 3
        set -g renumber-windows on

        # otherwise nightfox theme does not look right in neovim
        set -ga terminal-overrides ",xterm-256color:Tc"

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # resize panes
        bind -n C-Left resize-pane -L 10
        bind -n C-Right resize-pane -R 10
        bind -n C-Up resize-pane -U 10
        bind -n C-Down resize-pane -D 10

        unbind-key N
        bind N new-session -s "startname" \; run-shell "tmux rename-session $(echo tmp-$(shuf -i 0-1000 -n1))>/dev/null"
        unbind-key s
        bind-key s display-popup -E -w '20%' -h '20%' '~/dotfiles/tmux/tmuxinator-fzf-start.sh'
        unbind-key o
        bind-key o display-popup -E -w '20%' -h '20%' '~/dotfiles/tmux/tmuxinator-fzf-session.sh'

        # Smart pane switching with awareness of vim splits
        is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'
        bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
        bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
        bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
        bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

        # better closing
        unbind-key x               # unbind-key “x” from it’s current job of “ask and then close”
        bind-key x kill-pane       # rebind-key it to just “close”
        bind-key X kill-session    # key combo for killing the entire session - <prefix> + shift + x''

        + (if darkTheme then ''
        # Nightfox colors for Tmux
        # Style: nordfox
        # Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nordfox/nightfox_tmux.tmux
        set -g mode-style "fg=#81a1c1,bg=#4b5668"
        set -g message-style "fg=#81a1c1,bg=#4b5668"
        set -g message-command-style "fg=#81a1c1,bg=#4b5668"
        set -g pane-border-style "fg=#4b5668"
        set -g pane-active-border-style "fg=#81a1c1"
        set -g status "on"
        set -g status-justify "left"
        set -g status-style "fg=#81a1c1,bg=#232831"
        set -g status-left-length "100"
        set -g status-right-length "100"
        set -g status-left-style NONE
        set -g status-right-style NONE
        set -g status-left "#[fg=#3b4252,bg=#81a1c1,bold] #S #[fg=#81a1c1,bg=#232831,nobold,nounderscore,noitalics]"
        set -g status-right "#[fg=#232831,bg=#232831,nobold,nounderscore,noitalics]#[fg=#81a1c1,bg=#232831] #{prefix_highlight} #[fg=#4b5668,bg=#232831,nobold,nounderscore,noitalics]#[fg=#81a1c1,bg=#4b5668] %Y-%m-%d  %I:%M %p #[fg=#81a1c1,bg=#4b5668,nobold,nounderscore,noitalics]#[fg=#3b4252,bg=#81a1c1,bold] #h "
        setw -g window-status-activity-style "underscore,fg=#9DA2AC,bg=#232831"
        setw -g window-status-separator ""
        setw -g window-status-style "NONE,fg=#9DA2AC,bg=#232831"
        setw -g window-status-format "#[fg=#232831,bg=#232831,nobold,nounderscore,noitalics]#[default] #I #W #F #[fg=#232831,bg=#232831,nobold,nounderscore,noitalics]|"
        setw -g window-status-current-format "#[fg=#232831,bg=#4b5668,nobold,nounderscore,noitalics]#[fg=#81a1c1,bg=#4b5668,bold] #I #W #F #[fg=#4b5668,bg=#232831,nobold,nounderscore,noitalics]|"
        '' else ''
        # Nightfox colors for Tmux
        # Style: dayfox
        # Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/dayfox/nightfox_tmux.tmux
        set -g mode-style "fg=#6080b0,bg=#AAACB3"
        set -g message-style "fg=#6080b0,bg=#AAACB3"
        set -g message-command-style "fg=#6080b0,bg=#AAACB3"
        set -g pane-border-style "fg=#AAACB3"
        set -g pane-active-border-style "fg=#6080b0"
        set -g status "on"
        set -g status-justify "left"
        set -g status-style "fg=#6080b0,bg=#D8D8D8"
        set -g status-left-length "100"
        set -g status-right-length "100"
        set -g status-left-style NONE
        set -g status-right-style NONE
        set -g status-left "#[fg=#1d344f,bg=#6080b0,bold] #S #[fg=#6080b0,bg=#D8D8D8,nobold,nounderscore,noitalics]"
        set -g status-right "#[fg=#D8D8D8,bg=#D8D8D8,nobold,nounderscore,noitalics]#[fg=#6080b0,bg=#D8D8D8] #{prefix_highlight} #[fg=#AAACB3,bg=#D8D8D8,nobold,nounderscore,noitalics]#[fg=#6080b0,bg=#AAACB3] %Y-%m-%d  %I:%M %p #[fg=#6080b0,bg=#AAACB3,nobold,nounderscore,noitalics]#[fg=#1d344f,bg=#6080b0,bold] #h "
        setw -g window-status-activity-style "underscore,fg=#3F5269,bg=#D8D8D8"
        setw -g window-status-separator ""
        setw -g window-status-style "NONE,fg=#3F5269,bg=#D8D8D8"
        setw -g window-status-format "#[fg=#D8D8D8,bg=#D8D8D8,nobold,nounderscore,noitalics]#[default] #I #W #F #[fg=#D8D8D8,bg=#D8D8D8,nobold,nounderscore,noitalics]|"
        setw -g window-status-current-format "#[fg=#D8D8D8,bg=#AAACB3,nobold,nounderscore,noitalics]#[fg=#6080b0,bg=#AAACB3,bold] #I #W #F #[fg=#AAACB3,bg=#D8D8D8,nobold,nounderscore,noitalics]|"
        '');
    };

    zsh = {
      enable = true;
      sessionVariables = {
        THEME = if darkTheme then "dark" else "light";
      };
      oh-my-zsh = {
        enable = true;
        extraConfig = ''
          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent#lazy
          zstyle :omz:plugins:ssh-agent lazy yes

          # https://github.com/Aloxaf/fzf-tab#configure
          # disable sort when completing `git checkout`
          zstyle ':completion:*:git-checkout:*' sort false
          # set descriptions format to enable group support
          zstyle ':completion:*:descriptions' format '[%d]'
          # set list-colors to enable filename colorizing
          zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
          # preview directory's content with exa when completing cd
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
          # switch group using `,` and `.`
          zstyle ':fzf-tab:*' switch-group ',' '.'
          # text color
          # see https://github.com/Aloxaf/fzf-tab/wiki/Configuration#default-color
          zstyle ':fzf-tab:*' default-color $'\033[30m'
          # see https://man.archlinux.org/man/fzf.1.en#color=
          zstyle ':fzf-tab:*' fzf-flags ${ if darkTheme then "--color=dark" else "--color=light"}


          # https://github.com/junegunn/fzf#settings
          _fzf_compgen_path() {
            fd --hidden --follow --no-ignore --exclude ".git" . "$1"
          }
          _fzf_compgen_dir() {
            fd --type d --hidden --follow --no-ignore --exclude ".git" . "$1"
          }

          bindkey 'jk' vi-cmd-mode
          bindkey -s '^F' "zi\n"


          # TODO make this work in nix
          # https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#zsh
          # export FZF_COMPLETION_TRIGGER=""
          # bindkey '^T' fzf-completion
          # bindkey '^I' $fzf_default_completion

          # configure vi-mode plugin https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode#settings
          export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
          export VI_MODE_SET_CURSOR=true

          # configure BAT
          export BAT_THEME=${if darkTheme then "OneHalfDark" else "OneHalfLight"}

          # WSL 2 specific settings.
          if grep -q "microsoft" /proc/version &>/dev/null; then
            # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
            export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3  }'):0"
          fi

        '';

        plugins = [
          "httpie"
          "ripgrep"
          "fd"
          "git"
          "docker"
          "docker-compose"
          "gradle"
          "vi-mode"
          "npm"
          "ssh-agent"
          "tmuxinator"
          "gh"
          "web-search"
          "aws"
          "asdf"
          "zoxide"
        ];
      };
      shellAliases = {
        # git
        gll="git log --graph --branches --remotes --tags --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";

        # append aliases
        "-g H"="| head";
        "-g T"="| tail";
        "-g F"="| fzf";
        "-g L"="| less";
        "-g J"="| jq";
        "-g Y"="| xclip -selection clip";

        # add confirmation
        rm="rm -i";
        cp="cp -i";
        mv="mv -i";

        # better cli
        cat="bat";
        du="ncdu ${if darkTheme then "--color dark " else ""} -rr -x --exclude .git --exclude node_modules";
        ls="exa --oneline --icons";
        la="exa -la --icons";
        lt="exa -la --tree --icons";

        # misc
        clr="clear";
        cd="z";

        # neovim
        v="nvim";
        vim="nvim";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  fonts.fontconfig.enable = true; # for Hack Nerdfont

}
