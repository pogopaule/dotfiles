#!/bin/sh

pushd ~/dotfiles
nix build .#homeManagerConfigurations.haflinger.activationPackage
./result/activate
popd
