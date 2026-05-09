typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Must be at the very top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Editor
export EDITOR=nvim
alias vim='nvim'

# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Prevent double compinit, skip security check to avoid compaudit/zrecompile
skip_global_compinit=1
typeset -gA ZINIT
ZINIT[COMPINIT_OPTS]=-C

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Run compinit once with -C (skips compaudit/zrecompile), then replay
autoload -Uz compinit
compinit -C
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# NVM - lazy load for faster startup
export NVM_DIR="$HOME/.config/nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm "$@"; }
npx()  { nvm; npx "$@"; }

# Angular CLI completion (cached)
_NG_COMPLETION_CACHE="$HOME/.cache/ng-completion.zsh"
if [[ ! -f "$_NG_COMPLETION_CACHE" ]]; then
  ng completion script > "$_NG_COMPLETION_CACHE" 2>/dev/null
fi
source "$_NG_COMPLETION_CACHE"

# Brew (cached)
_BREW_CACHE="$HOME/.cache/brew-shellenv.zsh"
if [[ ! -f "$_BREW_CACHE" ]]; then
  /home/linuxbrew/.linuxbrew/bin/brew shellenv > "$_BREW_CACHE" 2>/dev/null
fi
source "$_BREW_CACHE"

# Go - static paths instead of goenv init subprocess
export GOENV_ROOT="$HOME/.goenv"
export GOPATH="$HOME/go"
export PATH="$GOENV_ROOT/shims:$GOENV_ROOT/bin:$GOPATH/bin:$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Android
export ANDROID_HOME="/home/shino/Android/Sdk"
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH
unset ANDROID_SDK_ROOT
export QT_QPA_PLATFORM=xcb
alias android-emu="QT_QPA_PLATFORM=xcb ~/Android/Sdk/emulator/emulator -avd Medium_Phone -gpu host -feature -Vulkan"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# pipx / local bins
case ":$PATH:" in
  *:"/home/shino/.local/bin":*) ;;
  *) export PATH="/home/shino/.local/bin:$PATH" ;;
esac

# opencode
export PATH=/home/shino/.opencode/bin:$PATH

# Vivaldi
export EDGE_PATH="/usr/bin/vivaldi"

# Locale (required by tmux for symbol rendering)
export LANG="en_IN.UTF-8"
export LC_ALL="en_IN.UTF-8"

# iNiR environment
export INIR_VENV="/home/shino/.local/state/quickshell/.venv"
export ILLOGICAL_IMPULSE_VIRTUAL_ENV="$INIR_VENV"

# CachyOS zsh config (at end to avoid interfering with instant prompt)
source /usr/share/cachyos-zsh-config/cachyos-config.zsh
