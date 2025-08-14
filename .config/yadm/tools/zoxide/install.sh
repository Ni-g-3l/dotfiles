zoxide --version
tool_installed=$? 

if [ $tool_installed != 0 ]; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi
