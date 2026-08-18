#!/usr/bin/env bash
set -e

ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

install_zsh_custom() {
    local kind=$1
    local repo_url=$2
    local name="$(basename "${repo_url}" .git)"
    local dir="${ZSH_CUSTOM}/${kind}s/${name}"

    if [ ! -d "${dir}" ]; then
        git clone --quiet ${repo_url} ${dir}
        echo "Downloaded zsh ${kind} \"${name}\""
    fi
}

install_dotfile() {
    local dotfile=$1
    local target="${HOME}/${dotfile}"

    mkdir -p "$(dirname "${target}")"

    if [ -f "${target}" ]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "${target}" "${backup}"
        echo "Created backup \"${backup}\""
    fi

    curl -fsSL https://raw.githubusercontent.com/jcosentino11/dotfiles/main/${dotfile} -o ${target}
    echo "Downloaded \"${target}\""
}

configure_zsh() {
    if [ ! -d "${ZSH}" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    install_zsh_custom theme https://github.com/romkatv/powerlevel10k.git

    install_zsh_custom plugin https://github.com/zdharma-continuum/fast-syntax-highlighting.git
    install_zsh_custom plugin https://github.com/marlonrichert/zsh-autocomplete.git
    install_zsh_custom plugin https://github.com/zsh-users/zsh-autosuggestions

    install_dotfile .zshrc
    install_dotfile .zprofile
    install_dotfile .p10k.zsh

    install_dotfile .hushlogin
}

configure_git() {
    install_dotfile .gitconfig
    install_dotfile .config/git/ignore
}

configure_claude() {
    install_dotfile .claude/CLAUDE.md
    install_dotfile .claude/settings.json
}

main() {
    configure_zsh
    configure_git
    configure_claude
    echo "Installation complete!"
    echo "Please run \"source ~/.zshrc\" to apply any changes"
}

main
