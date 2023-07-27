{ pkgs }:
{
  programs.zsh = {
    enable = true;
    plugins = [
      { name = "fzf-tab"; src = "${pkgs.zsh-fzf-tab}/share/fzf-tab"; }
    ];
    initExtra = ''
      # https://github.com/jeffreytse/zsh-vi-mode#nix
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # https://github.com/jeffreytse/zsh-vi-mode#custom-escape-key
      ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

      # https://github.com/jeffreytse/zsh-vi-mode/issues/127#issuecomment-1025292052
      function zvm_after_init() {
        zvm_bindkey viins '^R' fzf-history-widget
      }

      # https://github.com/junegunn/fzf/discussions/2791
      export FZF_COMPLETION_TRIGGER=""
      bindkey -M viins '^T' fzf-completion

      # https://github.com/Aloxaf/fzf-tab#configure
      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set descriptions format to enable group support
      zstyle ':completion:*:descriptions' format '[%d]'
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      # preview directory's content with exa when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
      # switch group using `,` and `.`
      zstyle ':fzf-tab:*' switch-group ',' '.'
      # text color
      # see https://github.com/Aloxaf/fzf-tab/wiki/Configuration#default-color
      zstyle ':fzf-tab:*' default-color $'\033[30m'

      export FZF_DEFAULT_OPTS="--color="$(if [ -f ~/.theme ] && [ $(\cat ~/.theme) = "dark" ]; then echo "dark"; else echo "light"; fi)""

      # WSL 2 specific settings.
      if grep -q "microsoft" /proc/version &>/dev/null; then
        # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
        export DISPLAY="$(ip route | awk '/default/ { print $3  }'):0"
      fi

      # https://www.npmjs.com/package/@githubnext/github-copilot-cli
      eval "$(github-copilot-cli alias -- "$0")"

      function toggleTheme() {
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
      }
    '';
    oh-my-zsh = {
      enable = true;
      extraConfig = ''
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent#lazy
        zstyle :omz:plugins:ssh-agent lazy yes

        source ~/.zshrc.local
      '';

      plugins = [
        "httpie"
        "ripgrep"
        "fd"
        "git"
        "docker"
        "docker-compose"
        "gradle"
        "npm"
        "ssh-agent"
        "tmuxinator"
        "gh"
        "web-search"
        "aws"
        "zoxide"
      ];
    };
    shellAliases = {
      # git
      git = "LANGUAGE=en git"; # fix strange language bug that happens because LANGUAGE is set to en_US:de
      gll = "git log --graph --branches --tags --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      gsa = "git secret add";
      gdf = "git diff $@ --name-only | fzf -m --reverse --ansi --preview-window=right,70% --preview 'git diff $@ --color=always -- {-1} | ${pkgs.diff-so-fancy}/bin/diff-so-fancy'";
      gcop = "git checkout -p";

      # append aliases
      "-g H" = "| head";
      "-g T" = "| tail";
      "-g F" = "| fzf";
      "-g L" = "| less";
      "-g J" = "| jq";
      "-g Y" = "| xclip -selection clip";

      # add confirmation
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      # better cli
      cat = "bat --theme \"$(if [ -f ~/.theme ] && [ $(\\cat ~/.theme) = \"dark\" ]; then echo \"OneHalfDark\"; else echo \"OneHalfLight\"; fi)\"";
      du = "ncdu --color \"$(if [ -f ~/.theme ] && [ $(\\cat ~/.theme) = \"dark\" ]; then echo \"dark\"; else echo \"dark-bg\"; fi)\" -rr -x --exclude .git --exclude node_modules";
      glow = "glow -s \"$(if [ -f ~/.theme ] && [ $(\\cat ~/.theme) = \"dark\" ]; then echo \"dark\"; else echo \"light\"; fi)\"";
      ls = "exa --oneline --icons";
      la = "exa -la --icons";
      lt = "exa -la --tree --icons";

      # misc
      h = "http";
      clr = "clear";
      tldrf = "tldr --list | fzf --preview \"tldr {1} --color=always\" --preview-window=right,70% | xargs tldr";
      rmrf = "rm -rf";

      # neovim
      v = "nvim";
      vim = "nvim";
    };
  };
}
