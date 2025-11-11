YADM_FOLDER=$HOME/.config/yadm

source $YADM_FOLDER/alias.sh

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

. "$HOME/.cargo/env"

export PATH=$PATH:/opt/nvim-linux-x86_64/bin
export PATH=$PATH:$HOME/.local/bin

eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"
eval "$(zoxide init bash)"

