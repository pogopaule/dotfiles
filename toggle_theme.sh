if grep -q "dark" ~/.theme; then
    echo "light" > ~/.theme
    tmux source-file ~/dotfiles/tmux/dawnfox.conf
    export FZF_DEFAULT_OPTS='--color=light'
else
    echo "dark" > ~/.theme
    tmux source-file ~/dotfiles/tmux/nordfox.conf
    export FZF_DEFAULT_OPTS='--color=dark'
fi

sudo touch ~/.config/wezterm/wezterm.lua
