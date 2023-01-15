# TODO
# - enable kde night colors
# - ff extensions like vimium and ublock
{ config, pkgs, ... }:
{
  # activate flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = "pogopaule";
      };
    };
    desktopManager.plasma5.enable = true;
    layout = "de";
    xkbVariant = "";
    xkbOptions = "ctrl:swapcaps";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.pogopaule = {
    isNormalUser = true;
    description = "pogopaule";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # https://nixos.wiki/wiki/Command_Shell#Changing_default_shell
  environment.shells = with pkgs; [ zsh ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.11"; # Did you read the comment?
}
