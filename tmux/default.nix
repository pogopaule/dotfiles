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
    extraConfig = builtins.readFile ./tmux.conf + (
      if darkTheme then builtins.readFile ./nordfox.conf
      else builtins.readFile ./dayfox.conf
    );
  };
}
