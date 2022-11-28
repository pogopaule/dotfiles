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
      colors = if darkTheme then {
        primary = {
          background = "0x2e3440";
          foreground = "0xcdcecf";
        };
        cursor = {
          text = "0xffffff";
          cursor = "0xff00ff";
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
        cursor = {
          text = "0xffffff";
          cursor = "0x000000";
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
}
