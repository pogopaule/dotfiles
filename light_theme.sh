#! /bin/bash

sed -i 's/nordfox/dayfox/' ./tmux/tmux.conf
sed -i 's/nordfox/dayfox/' ./alacritty/alacritty.yml
sed -i 's/fox = "nordfox"/fox = "dayfox/' ./nvim/lua/pogopaule/plugins/simple_setups.lua
