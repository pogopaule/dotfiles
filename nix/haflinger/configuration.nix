{ pkgs, ... }: {

  programs.zsh.enable = true;

  nix.settings.trusted-users = [ "root" "fabian" ];

  users.users.fabian = {
    name = "fabian";
    home = /Users/fabian;
  };

  environment =
    {
      shells = [ pkgs.bash pkgs.zsh ];
      systemPackages = [ pkgs.coreutils ];
    };

  nix.extraOptions = "experimental-features = nix-command flakes";

  services.nix-daemon.enable = true;

  system = {
    defaults = {
      finder.AppleShowAllExtensions = true;
      NSGlobalDomain.InitialKeyRepeat = 18;
      NSGlobalDomain.KeyRepeat = 2;
      screensaver.askForPasswordDelay = 180;
    };
  };

  fonts = {
    packages = [
      (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  homebrew = {
    enable = true;
    global.brewfile = true;
    casks = [
      "raycast"
      "todoist"
      "spotify"
      "cyberduck"
      "firefox"
      "1password"
      "gpg-suite"
      "amethyst"
      "docker"
      "unnaturalscrollwheels"
      "google-chrome"
      "espanso"
      "hazeover"
      "stats"
      "skitch"
      "obsidian"
      "qbserve"
      "postman"
    ];
    taps = [ ];
    brews = [
      "mysql"
    ];
  };

  system.stateVersion = 5;
}
