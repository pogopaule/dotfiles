{ pkgs, darkTheme, ... }:

{
  home = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" ]; })
      signal-desktop
      thunderbird
      todoist-electron
      libreoffice
      pcloud
      keepassxc
      spotify
      libimobiledevice
      ifuse
      vlc
    ];
  };

  programs = {
    wezterm = {
      enable = true;
      extraConfig = ''
        return {
          hide_tab_bar_if_only_one_tab = true,
          font_size = 16.0,
          font = wezterm.font('Hack Nerd Font'),
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
        }
      '';
    };
  };

  fonts.fontconfig.enable = true; # for Hack Nerdfont

  imports = [
    (import ../alacritty { inherit darkTheme; })
  ];

  programs = {
    firefox.enable = true;
  };
}
