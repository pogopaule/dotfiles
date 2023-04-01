{
  description = "pogopaule's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv/v0.6.2";
  };

  outputs = { nixpkgs, nixpkgs-master, home-manager, devenv, ... }:
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

    in
    {
      homeManagerConfigurations = {
        noDesktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme devenv; })
            {
              home = {
                username = "pogopaule";
                stateVersion = "22.11";
                homeDirectory = "/home/pogopaule";
              };
            }
          ];
        };
        haflinger = home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;
            modules = [
              (import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme devenv; })
              (import ./nix/home-haflinger.nix { inherit pkgs pkgs-master darkTheme; })
              {
                home = {
                  username = "pogopaule";
                  stateVersion = "22.11";
                  homeDirectory = "/home/pogopaule";
                };
              }
            ];
          };
        desktop = home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;
            modules = [
              (import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme devenv; })
              (import ./nix/home-desktop.nix { inherit pkgs darkTheme; })
              {
                home = {
                  username = "pogopaule";
                  stateVersion = "22.11";
                  homeDirectory = "/home/pogopaule";
                };
              }
            ];
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
