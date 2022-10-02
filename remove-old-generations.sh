#!/bin/sh
home-manager expire-generations -14days
sudo nix-collect-garbage --delete-older-than 14d
