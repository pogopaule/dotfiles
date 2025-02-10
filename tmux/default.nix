{ pkgs }:
{
  programs.tmux = {
    enable = true;
    keyMode = "emacs";
    shortcut = "a";
    baseIndex = 1;
    historyLimit = 50000;
    escapeTime = 0;
    terminal = "xterm-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    tmuxinator.enable = true;
    sensibleOnTop = false;
    plugins = with pkgs.tmuxPlugins; [
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
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
