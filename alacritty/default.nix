{ darkTheme }:
{
  programs.alacritty = {
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
      colors =
        (if darkTheme then
          (builtins.fromJSON (builtins.readFile ./nordfox.json)).colors
        else
          (builtins.fromJSON (builtins.readFile ./dawnfox.json)).colors)
        //
        {
          cursor = {
            text = "0xffffff";
            cursor = "0xff00ff";
          };
        }
      ;
    };
  };
}
