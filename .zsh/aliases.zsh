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
alias gohome="cd $HOME"
alias zprojects="cd $HOME/projects/zillow"

alias zshrc="nvim ~/.zshrc"
alias sourcezsh="source ~/.zshrc"

alias dcu='docker-compose up'
alias dcd='docker-compose down'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias venv="source .venv/bin/activate"

via() {
  $EDITOR $(git ls-files --modified --others --exclude-standard) $@
}
alias vm=via

alias dockerstopall='docker stop $(docker ps -a -q)'
alias dils='docker image ls'
alias dirm='docker image rm'
alias dcls='docker ps'
alias dsp='docker system prune'
alias dspf='docker system prune -f'
