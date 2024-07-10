# For a full list of active aliases, run `alias`.

# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias ll="ls -larth"
alias ls='ls -a --color=auto'
alias c="clear"
alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias v="nvim"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"

alias zshrc="nvim ~/.zshrc"
alias sourcezsh="source ~/.zshrc"

alias dcu='docker-compose up'
alias dcd='docker-compose down'
