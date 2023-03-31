{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration-panther.nix
    ];

  networking.hostName = "panther";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-3c670b0c-d629-4222-93f8-90cae8e078ac".device = "/dev/disk/by-uuid/3c670b0c-d629-4222-93f8-90cae8e078ac";
  boot.initrd.luks.devices."luks-3c670b0c-d629-4222-93f8-90cae8e078ac".keyFile = "/crypto_keyfile.bin";

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
}
