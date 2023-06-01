{ pkgs, ... }: {
  programs.zsh.enable = true;
  environment.shells = [ pkgs.bash pkgs.zsh ];
  environment.loginShell = pkgs.zsh;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  systemPackages = [ pkgs.coreutils ];
  services.nix-daemon.enable = true;
  system.defaults.finder.AppleShowAllExtensions = true;
}
