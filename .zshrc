# ===================================
# Oh My ZSH 
# ===================================

export plugins=(
    git 
    gpg-agent 
    zsh-syntax-highlighting  
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
