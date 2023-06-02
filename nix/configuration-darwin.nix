{ pkgs, ... }: {

  programs.zsh.enable = true;

  environment =
    {
      shells = [ pkgs.bash pkgs.zsh ];
      loginShell = pkgs.zsh;
      systemPackages = [ pkgs.coreutils ];
    };

  nix.extraOptions = "experimental-features = nix-command flakes";

  services.nix-daemon.enable = true;

  system = {
    defaults = {
      finder.AppleShowAllExtensions = true;
      NSGlobalDomain.InitialKeyRepeat = 14;
      NSGlobalDomain.KeyRepeat = 1;
      screensaver.askForPasswordDelay = 180;
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  homebrew = {
    enable = true;
    global.brewfile = true;
    casks = [];
  };

}
