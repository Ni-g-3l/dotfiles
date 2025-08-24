# Alias declaration

export EDITOR="micro"

## System 

alias "s."="source ~/.bashrc"
alias "u."='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y'

## Tools

alias "cd"="z"
alias "cat"="batcat"
alias "g."="git"
alias "d."="htop"
alias "f."="yazi $1"
alias "sf."="sh $HOME/.config/yadm/tools/filemanager/sf.sh $@"
alias "lg."="lazygit"
alias "e."="$EDITOR"

