#!/bin/sh

pushd ~/dotfiles
nix build .#homeManagerConfigurations.desktop.activationPackage
./result/activate
popd
