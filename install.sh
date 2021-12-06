#!/usr/bin/env bash

DOTFILES=$(pwd)

function backup() {

}

function setup_shell() {

    echo "Configuring zsh shell"

    zsh_path="$(which zsh)"

    if ! grep "$zsh_path" /etc/shells; then
        echo "adding $zsh_path to /etc/shells"
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
        echo "default shell changed to $zsh_path"
    fi

}

function setup_symlinks() {

    # Home directory
    ln -sf $DOTFILES/.bashrc $HOME/.bashrc
    ln -sf $DOTFILES/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig
    ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf

    # Config directory
    [ ! -d $HOME/.config ] && mkdir $HOME/.config

    [ -d $HOME/.config/alacritty ] && rm -rf $HOME/.config/alacritty
    ln -sf $DOTFILES/.config/alacritty $HOME/.config/alacritty

    # Create nvim symlinks
    [ -d $HOME/.config/nvim ] && rm -rf $HOME/.config/nvim
    ln -sf $DOTFILES/.config/nvim $HOME/.config/nvim

    # Create vim symlinks to neovim equivalent, i.e ~/.vimrc and ~/.vim
    ln -sf $DOTFILES/.config/nvim $HOME/.vim
    ln -sf $DOTFILES/.config/nvim/init.vim $HOME/.vimrc

    # Local directory
    [ ! -d $HOME/.local ] && mkdir -p $HOME/.local/share
    [ ! -d $HOME/.local/share ] && mkdir $HOME/.local/share
    [ -d $HOME/.local/share/fonts ] && rm -rf $HOME/.local/share/fonts
    ln -sf $DOTFILES/.local/share/fonts $HOME/.local/share/fonts
}

case "$1" in
    backup)
        backup
        ;;
    shell)
        setup_shell
        ;;
    link)
        setup_symlinks
        ;;
    all)
        backup
        setup_shell
        setup_symlinks
        ;;
    *)
        echo -e "\nUsage: $(basename "$0") {backup|shell|link|all}\n"
        exit 1
        ;;
esac

echo " dotfiles configuration bootstrapping process finished!"
