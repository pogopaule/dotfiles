#!/bin/sh

pushd ~/dotfiles
nix build .#homeManagerConfigurations.noDesktop.activationPackage
./result/activate
popd
