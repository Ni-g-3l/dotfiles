# Install Zellij terminal multiplexer

zellij -V
tool_installed=$?

if [ $tool_installed != 0 ]; then
    cargo install --locked zellij
fi
