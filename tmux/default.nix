{ pkgs, darkTheme }:
{
  programs.tmux = {
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
}
