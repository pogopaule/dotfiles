{
  description = "pogopaule's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-master, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-master = import nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };

    darkTheme = true;

  in {
    homeManagerConfigurations = {
      noDesktop = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "pogopaule";
        stateVersion = "22.05";
        homeDirectory = "/home/pogopaule";
        configuration = {
          imports = [
            ( import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme; })
          ];
        };
      };
      haflinger = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "pogopaule";
        stateVersion = "22.05";
        homeDirectory = "/home/pogopaule";
        configuration = {
          imports = [
            ( import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme; })
            ( import ./nix/home-haflinger.nix { inherit pkgs pkgs-master darkTheme; })
          ];
        };
      };
      desktop = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "pogopaule";
        stateVersion = "22.05";
        homeDirectory = "/home/pogopaule";
        configuration = {
          imports = [
            ( import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme; })
            ( import ./nix/home-desktop.nix { inherit pkgs darkTheme; })
          ];
        };
      };
    };
    nixosConfigurations = {
      panther = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nix/configuration-core.nix
          ./nix/configuration-panther.nix
        ];
      };
     silverback = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nix/configuration-core.nix
          ./nix/configuration-silverback.nix
        ];
      };
     haflinger = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          /etc/nixos/configuration.nix
        ];
      };
    };
  };
}
