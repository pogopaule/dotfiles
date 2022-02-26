#! /bin/bash

sed -i 's/dayfox/nordfox/' ./tmux/tmux.conf
sed -i 's/dayfox/nordfox/' ./alacritty/alacritty.yml
sed -i 's/fox = "dayfox"/fox = "nordfox/' ./nvim/lua/pogopaule/plugins/simple_setups.lua
