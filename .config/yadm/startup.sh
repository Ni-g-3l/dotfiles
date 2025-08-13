YADM_FOLDER=$HOME/.config/yadm

source $YADM_FOLDER/alias.sh

. "$HOME/.cargo/env"

export PATH=$PATH:/opt/nvim-linux-x86_64/bin

eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"