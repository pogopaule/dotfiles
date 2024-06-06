{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "panther";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-9b1ff84f-34a0-4e3c-93eb-53774520ea0e".device = "/dev/disk/by-uuid/9b1ff84f-34a0-4e3c-93eb-53774520ea0e";
  boot.initrd.luks.devices."luks-9b1ff84f-34a0-4e3c-93eb-53774520ea0e".keyFile = "/crypto_keyfile.bin";

  # see https://nixos.wiki/wiki/IOS
  services.usbmuxd.enable = true;

  # https://nixos.wiki/wiki/Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;

  networking.firewall.allowedTCPPorts = [ 58080 ];

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 58080;
    user = "pogopaule";
    dataDir = "/home/pogopaule/Documents/paperless";
    extraConfig = {
      LD_LIBRARY_PATH = "${pkgs.lib.getLib pkgs.mkl}/lib";
      PAPERLESS_AUTO_LOGIN_USERNAME = "admin";
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
    };
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.pop-shell
  ];
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11",     MODE:="0666",     SYMLINK+="stm32_dfu"
  '';
  users.groups.plugsdev.members = [ "pogopaule" ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
