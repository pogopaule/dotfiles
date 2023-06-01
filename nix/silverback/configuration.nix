{ config, pkgs, ... }:
{
  imports =
    [
      ./silverback/hardware-configuration.nix
    ];

  networking.hostName = "silverback";
}
