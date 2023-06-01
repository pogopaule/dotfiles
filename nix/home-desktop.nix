{ pkgs, pkgs-master, darkTheme, devenv, ... }:

{
  imports = [
    (import ./home-core.nix { inherit pkgs pkgs-master darkTheme devenv; })
  ];

  home = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
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
      xclip
      meld
    ] ++ [ pkgs-master.uhk-agent ];
  };

  programs = {
    wezterm = {
      enable = true;
      package = pkgs-master.wezterm;
      extraConfig = ''
        return {
          hide_tab_bar_if_only_one_tab = true,
          default_prog = { "zsh", "--login", "-c", "tmux attach -t default || tmux new -s default" },
          font_size = 18.0,
          font = wezterm.font('Iosevka Nerd Font'),
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
          audible_bell = 'Disabled',
          warn_about_missing_glyphs = false,
          keys = {
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
            }
          }
        }
      '';
    };
    vscode = {
      enable = true;
      package = pkgs-master.vscode;
    };
  };

  fonts.fontconfig.enable = true; # for Nerdfont

  programs = {
    firefox.enable = true;
    chromium.enable = true;
  };
}
