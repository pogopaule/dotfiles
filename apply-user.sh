#!/bin/sh

pushd ~/dotfiles
nix build .#homeManagerConfigurations.pogopaule.activationPackage
./result/activate
popd
