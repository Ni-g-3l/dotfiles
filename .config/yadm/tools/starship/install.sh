starship -V
tool_installed=$?

if [ $tool_installed != 0 ]; then
    curl -sS https://starship.rs/install.sh | sh
fi
