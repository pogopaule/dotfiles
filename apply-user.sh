#!/bin/sh

pushd ~/dotfiles
nix build .#homeManagerConfigurations.pogopaule.activationPacakage
./result/activate
popd
