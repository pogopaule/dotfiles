{ pkgs }:
{
  programs.zsh = {
    enable = true;
    plugins = [
      { name = "fzf-tab"; src = "${pkgs.zsh-fzf-tab}/share/fzf-tab"; }
    ];
    history = {
      share = true;
      save = 70000;
      ignoreAllDups = true;
    };
    # zprof.enable = true; TODO: enable this once the new version o home-manager is released and time with /usr/bin/time zsh -i -c exit
    initExtra = ''
      # https://github.com/jeffreytse/zsh-vi-mode#nix
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # https://github.com/jeffreytse/zsh-vi-mode#custom-escape-key
      ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

      # https://github.com/jeffreytse/zsh-vi-mode/issues/127#issuecomment-1025292052
      function zvm_after_init() {
        zvm_bindkey viins '^R' fzf-history-widget
      }


      # https://github.com/jeffreytse/zsh-vi-mode/issues/19#issuecomment-1268057812
      if [[ $(uname) = "Darwin" ]]; then
        on_mac_os=0
      else
        on_mac_os=1
      fi

      cbread() {
        if [[ $on_mac_os -eq 0 ]]; then
          pbcopy
        else
          xclip -selection primary -i -f | xclip -selection secondary -i -f | xclip -selection clipboard -i
        fi
      }

      cbprint() {
        if [[ $on_mac_os -eq 0 ]]; then
          pbpaste
        else
          if   x=$(xclip -o -selection clipboard 2> /dev/null); then
            echo -n $x
          elif x=$(xclip -o -selection primary   2> /dev/null); then
            echo -n $x
          elif x=$(xclip -o -selection secondary 2> /dev/null); then
            echo -n $x
          fi
        fi
      }

      my_zvm_vi_yank() {
        zvm_vi_yank
        echo -en "''${CUTBUFFER}" | cbread
      }

      my_zvm_vi_delete() {
        zvm_vi_delete
        echo -en "''${CUTBUFFER}" | cbread
      }

      my_zvm_vi_change() {
        zvm_vi_change
        echo -en "''${CUTBUFFER}" | cbread
      }

      my_zvm_vi_change_eol() {
        zvm_vi_change_eol
        echo -en "''${CUTBUFFER}" | cbread
      }

      my_zvm_vi_put_after() {
        CUTBUFFER=$(cbprint)
        zvm_vi_put_after
        zvm_highlight clear # zvm_vi_put_after introduces weird highlighting for me
      }

      my_zvm_vi_put_before() {
        CUTBUFFER=$(cbprint)
        zvm_vi_put_before
        zvm_highlight clear # zvm_vi_put_before introduces weird highlighting for me
      }

      zvm_after_lazy_keybindings() {
        zvm_define_widget my_zvm_vi_yank
        zvm_define_widget my_zvm_vi_delete
        zvm_define_widget my_zvm_vi_change
        zvm_define_widget my_zvm_vi_change_eol
        zvm_define_widget my_zvm_vi_put_after
        zvm_define_widget my_zvm_vi_put_before

        zvm_bindkey visual 'y' my_zvm_vi_yank
        zvm_bindkey visual 'd' my_zvm_vi_delete
        zvm_bindkey visual 'x' my_zvm_vi_delete
        zvm_bindkey vicmd  'C' my_zvm_vi_change_eol
        zvm_bindkey visual 'c' my_zvm_vi_change
        zvm_bindkey vicmd  'p' my_zvm_vi_put_after
        zvm_bindkey vicmd  'P' my_zvm_vi_put_before
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
      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
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

      # make sure brew is on the path for M1
      # https://discourse.nixos.org/t/brew-not-on-path-on-m1-mac/26770/4
      if [[ $(uname -m) == 'arm64' ]]; then
           eval "$(/opt/homebrew/bin/brew shellenv)"
       fi

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
      }

      function ns() {
        nix shell nixpkgs#"$1"
      }

      export PATH=$PATH:~/dotfiles/scripts
    '';
    oh-my-zsh = {
      enable = true;
      extraConfig = ''
        source ~/.zshrc.local
      '';

      plugins = [
        "httpie"
        "git"
        "docker"
        "docker-compose"
        "gradle"
        "npm"
        "ssh-agent"
        "tmuxinator"
        "gh"
        "web-search"
        "zoxide"
        "kubectl"
      ];
    };
    shellGlobalAliases = {
      H = "| head";
      T = "| tail";
      F = "| fzf";
      L = "| less";
      J = "| jq";
      C = "| wc -l";
      E = "\ls . | entr";
    };
    shellAliases = {
      # git
      git = "LANGUAGE=en git"; # fix strange language bug that happens because LANGUAGE is set to en_US:de
      gll = "git log --graph --branches --tags --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      gsa = "git secret add";
      gdf = "git diff $@ --name-only | fzf -m --reverse --ansi --preview-window=right,70% --preview 'git diff $@ --color=always -- {-1} | ${pkgs.diff-so-fancy}/bin/diff-so-fancy'";
      gcop = "git checkout -p";
      gd = "GIT_EXTERNAL_DIFF=\"difft --color auto --background light --display side-by-side\" git diff";

      gprunesquashmerged = ''git checkout -q develop && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base develop $branch) && [[ $(git cherry develop $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'';
      gprunesquashmergeddry = ''git checkout -q develop && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base develop $branch) && [[ $(git cherry develop $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && echo "$branch is merged into develop and can be deleted"; done'';

      # add confirmation
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      # better cli
      cat = "bat --theme \"$(if [ -f ~/.theme ] && [ $(\\cat ~/.theme) = \"dark\" ]; then echo \"OneHalfDark\"; else echo \"OneHalfLight\"; fi)\"";
      glow = "glow -s \"$(if [ -f ~/.theme ] && [ $(\\cat ~/.theme) = \"dark\" ]; then echo \"dark\"; else echo \"light\"; fi)\"";
      # TODO: fix this workaround and configure gh-dash theme automatically
      ghdl = "gh dash --config ~/dotfiles/gh-dash/config-light.yml";
      ghdd = "gh dash --config ~/dotfiles/gh-dash/config-dark.yml";
      ls = "eza --oneline --icons";
      la = "eza -la --icons";
      lt = "eza -la --tree --icons";
      watch = "viddy";

      # misc
      p = "python";
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
