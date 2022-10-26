#!/bin/sh

pushd ~/dotfiles
sudo nixos-rebuild switch --flake .#haflinger --impure
popd
