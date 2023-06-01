{ pkgs, ... }: {
  programs.zsh.enable = true;
  environment =
    {
      shells = [ pkgs.bash pkgs.zsh ];
      loginShell = pkgs.zsh;
      systemPackages = [ pkgs.coreutils ];
    };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  services.nix-daemon.enable = true;
  system.defaults.finder.AppleShowAllExtensions = true;

  fonts.fontDir.enable = true;
  fonts.fonts = [
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
}
