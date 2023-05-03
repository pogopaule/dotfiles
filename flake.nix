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
      nixosConfigurations = {
        panther = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nix/configuration-core.nix
            ./nix/configuration-panther.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pogopaule = (import ./nix/home-desktop.nix { inherit pkgs pkgs-master darkTheme devenv; });
              };
            }
          ];
        };
        silverback = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nix/configuration-core.nix
            ./nix/configuration-silverback.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pogopaule = (import ./nix/home-core.nix { inherit pkgs pkgs-master darkTheme devenv; });
              };
            }
          ];
        };
      };
    };
}
