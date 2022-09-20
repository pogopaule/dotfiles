{

  description = "pogopaule's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      pogopaule = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "pogopaule";
        stateVersion = "22.05";
        homeDirectory = "/home/pogopaule";
        configuration = {
          imports = [
            ./home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
