#!/usr/bin/env zsh
set -e

ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

install_zsh_theme() {
    local repo_url=$1
    local theme_name="$(basename "${repo_url}" .git)"
    local theme_dir="${ZSH_CUSTOM}/themes/${theme_name}"

    if [ ! -d "${theme_dir}" ]; then
        git clone --quiet ${repo_url} ${theme_dir}
        echo "Downloaded zsh theme \"${theme_name}\""
    fi
}

install_zsh_plugin() {
    local repo_url=$1
    local plugin_name="$(basename "${repo_url}" .git)"
    local plugin_dir="${ZSH_CUSTOM}/plugins/${plugin_name}"
    
    if [ ! -d "${plugin_dir}" ]; then
        git clone --quiet ${repo_url} ${plugin_dir}
        echo "Downloaded zsh plugin \"${plugin_name}\""
    fi
}

install_dotfile() {
    local dotfile=$1

    if [ -f "${HOME}/${dotfile}" ]; then
        local backup="${HOME}/${dotfile}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "${HOME}/${dotfile}" "${backup}"
        echo "Created backup \"${backup}\""
    fi
    
    curl -fsSL https://raw.githubusercontent.com/jcosentino11/dotfiles/main/${dotfile} -o ${HOME}/${dotfile}
    echo "Downloaded \"${HOME}/${dotfile}\""
}

configure_zsh() {
    if [ ! -d "${ZSH}" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    install_zsh_theme https://github.com/romkatv/powerlevel10k.git
    install_zsh_plugin https://github.com/marlonrichert/zsh-autocomplete.git
    install_zsh_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git
    install_zsh_plugin https://github.com/zdharma-continuum/fast-syntax-highlighting.git
    install_zsh_plugin https://github.com/zsh-users/zsh-autosuggestions.git

    install_dotfile .zshrc
    install_dotfile .p10k.zsh
}

configure_git() {
    if [ "${DOTFILES_INCLUDE_PERSONAL:-false}" = "true" ]; then
        install_dotfile .gitconfig
    fi
}

main() {
    configure_zsh
    configure_git
    echo "Installation complete!"
}

main
