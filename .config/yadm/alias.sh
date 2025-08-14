# Alias declaration

export EDITOR="nvim"

function open_editor {
	zellij action new-tab -l editor -c $(pwd)
}

function open_git_ui {
	zellij action new-pane -f -- lazygit
}

## System 

alias "s."="source ~/.bashrc"
alias "u."='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y'

## Tools

alias "cd"="z"
alias "g."="git"
alias "d."="htop"
alias "f."="yazi $1"
alias "sf."="sh $HOME/.config/yadm/tools/filemanager/sf.sh $@"
alias "lg."="open_git_ui"
alias "e."="open_editor"

