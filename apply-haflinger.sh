nix build .#darwinConfigurations.haflinger.system
./result/sw/bin/darwin-rebuild switch --flake .
