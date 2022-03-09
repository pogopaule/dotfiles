# uncomment following line and line at bottom of this file to profile startup time of oh-my-zsh
# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell" # commented out in favour of starship

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Only load nvm when needed since it slows down the start of zsh
# export NVM_LAZY=1

# https://github.com/Aloxaf/fzf-tab#configure
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# text color
zstyle ':fzf-tab:*' default-color $'\033[30m'



# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux httpie ripgrep fd git docker docker-compose gradle vi-mode npm ssh-agent nvm tmuxinator gh fzf-tab)

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent#lazy
zstyle :omz:plugins:ssh-agent lazy yes

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR='vim'


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# git
alias gll="git log --graph --branches --remotes --tags --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias grema="git rebase master"
alias gbd="git branch --delete"
alias gnews='git fetch origin "$(git_current_branch)" && git log "$(git_current_branch)"..origin/"$(git_current_branch)"'
alias gscope="git log --pretty=oneline | sed -E 's/^.*\((.*)\):.*$/\1/' | sed '/[0-9a-f]* .*/d' | sort | uniq"
alias gtype="git log --pretty=oneline | sed -E 's/[0-9a-f]{40} (.*)\(.*/\1/' | sed '/[0-9a-f]* .*/d' | sort | uniq"

# append aliases
alias -g H='| head'
alias -g T='| tail'
alias -g F='| fzf'
alias -g L="| less"
alias -g J="| jq"
alias -g Y="| xclip -selection clip"

# add confirmation
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# vagrant
alias vs='vagrant ssh'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vdd='vagrant destroy'

# docker
alias dps='docker ps'
alias dpsa='docker ps -a'

# npm
alias nr='npm run'

# better cli
alias fd="fdfind"
alias cat='bat'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias ls="exa --oneline --icons"
alias tree="exa --tree --long --level=2"
alias lg="lazygit"
alias la="exa -la --icons"

# misc
alias gw='./gradlew'
alias v="vim"
alias clr="clear"


bindkey '^R' history-incremental-search-backward
bindkey 'jk' vi-cmd-mode


# configure BAT
export BAT_THEME=ansi-light

# configure vi-mode plugin https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode#settings
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

# configure FZF
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --no-ignore --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --no-ignore --exclude .git'
_fzf_compgen_path() {
  fdfind --hidden --follow --no-ignore --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fdfind --type d --hidden --follow --no-ignore --exclude ".git" . "$1"
}

# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then
  # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
  export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3  }'):0"
fi

# zsh settings that should not be comitted to git
source ~/.local_zshrc.zsh

# https://starship.rs/guide/#%F0%9F%9A%80-installation
eval "$(starship init zsh)"

# https://github.com/junegunn/fzf#using-git
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# uncomment following line and line at the very top of this file to profile startup time of oh-my-zsh
# zprof

