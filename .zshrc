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

ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# ===================================
# Podman
# ===================================

alias docker=podman

# ===================================
# LLMs
# ===================================

# aider config: https://aider.chat/docs/llms/ollama.html
export OLLAMA_API_BASE=http://127.0.0.1:11434
export OLLAMA_CONTEXT_LENGTH=8192
