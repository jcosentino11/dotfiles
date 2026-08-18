# ===================================
# Oh My ZSH
# ===================================

export plugins=(
    git
    gpg-agent
    fast-syntax-highlighting
    zsh-autocomplete
    zsh-autosuggestions
)

# make autocomplete less agressive
zstyle ':autocomplete:*' min-input 3

ZSH_THEME="powerlevel10k/powerlevel10k"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':omz:update' mode auto

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# restore default zsh history behavior
# (due to zsh-autocomplete)
bindkey '\e[A' up-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOB' down-line-or-history

# use tabs instead of right arrow to accept autosuggestion
# (due to zsh-autosuggestions)
bindkey '^I'   complete-word
bindkey '^I^I' autosuggest-accept


export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===================================
# Custom Aliases
# ===================================

alias docker=podman
alias python=python3

# ===================================
# direnv
# ===================================

command -v direnv >/dev/null && eval "$(direnv hook zsh)"
