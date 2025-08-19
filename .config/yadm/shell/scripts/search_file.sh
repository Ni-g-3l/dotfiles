#!/bin/bash

##
# Interactive search.
# Usage: `ff` or `ff <folder>`.
#
[ -n $1 ] && cd "$1" || exit # go to provided folder or noop
RG_DEFAULT_COMMAND="rg -i -C 2 -l --hidden --no-ignore-vcs"

selected=$(
FZF_DEFAULT_COMMAND="rg --files" fzf \
  -m \
  -e \
  --ansi \
  --reverse \
  --bind "f12:execute-silent:(subl -b {})" \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)

[ -n $selected ] && $EDITOR "$selected" # open multiple files in editor
