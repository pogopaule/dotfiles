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
    ];
  };

  fonts.fontconfig.enable = true; # for Hack Nerdfont

  imports = [
    ( import ../alacritty { inherit darkTheme; })
  ];

  programs = {
    firefox.enable = true;
  };
}
