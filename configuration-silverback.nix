{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration-silverback.nix
    ];

  networking.hostName = "silverback";
}
