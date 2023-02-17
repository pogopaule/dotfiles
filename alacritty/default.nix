{ darkTheme }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 13;
        normal.family = "Iosevka Nerd Font";
        bold.family = "Iosevka Nerd Font";
        italic.family = "Iosevka Nerd Font";
        bold_italic.family = "Iosevka Nerd Font";
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
