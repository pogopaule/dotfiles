{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration-haflinger.nix
    ];

  networking.hostName = "haflinger";
}
