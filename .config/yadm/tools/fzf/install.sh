fzf --version
tool_installed=$?
if [ $tool_installed != 0 ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi


