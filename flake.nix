{
  description = "pogopaule's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv/v0.6.2";
  };

  outputs = { nixpkgs, nixpkgs-master, home-manager, darwin, devenv, ... }:
    let
      darkTheme = true;
    in
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-master = import nixpkgs-master {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          haflinger = darwin.lib.darwinSystem {
            modules = [
              ./nix/configuration-darwin.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.fabian = (import ./nix/haflinger/home-manager.nix { inherit pkgs pkgs-master darkTheme devenv; });
                };
              }
            ];
          };
        };
      nixosConfigurations =
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
        in
        {
          panther = nixpkgs.lib.nixosSystem {
            modules = [
              ./nix/configuration-core.nix
              ./nix/panther/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.pogopaule = (import ./nix/panther/home-manager.nix { inherit pkgs pkgs-master darkTheme devenv; });
                };
              }
            ];
          };
          silverback = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            pkgs-master = import nixpkgs-master {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ./nix/configuration-core.nix
              ./nix/silverback/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.pogopaule = (import ./nix/silverback/home-manager.nix { inherit pkgs pkgs-master darkTheme devenv; });
                };
              }
            ];
          };
        };
    };
}
