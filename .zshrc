export DOTFILES=$HOME/.dotfiles

export ZSH_DIR=$HOME/.zsh

for file in ~/.zsh/*; do
    source "$file"
done

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
