rg --version
tool_installed=$?
if [ $tool_installed != 0 ]; then
    sudo apt-get install ripgrep
fi

