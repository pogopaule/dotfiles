#! /bin/bash

if grep -q nordfox ./tmux/tmux.conf
then
  echo "switching to light theme"
  OLD_THEME='nordfox'
  NEW_THEME='dayfox'
else
  echo "switching to dark theme"
  OLD_THEME='dayfox'
  NEW_THEME='nordfox'
fi

sed -i "s/$OLD_THEME/$NEW_THEME/" ./tmux/tmux.conf

if [ "$NEW_THEME" == "dayfox" ]
then
  sed -i "s/ansi\-dark/ansi\-light/" ./zshrc
else
  sed -i "s/ansi\-light/ansi\-dark/" ./zshrc
fi


sed -i "s/fox = '$OLD_THEME'/fox = '$NEW_THEME'/" ./nvim/lua/pogopaule/plugins/simple_setups.lua

if grep -q microsoft /proc/version; then
  sed -i "s/colors: \*$OLD_THEME/colors: \*$NEW_THEME/" /mnt/c/Users/SFA/AppData/Roaming/alacritty/alacritty.yml
else
  sed -i "s/colors: \*$OLD_THEME/colors: \*$NEW_THEME/" ./alacritty/alacritty.yml
fi
