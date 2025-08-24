batcat -V
tool_installed=$?

if [ $tool_installed != 0 ]; then
   sudo apt install bat -y
   mkdir -p $HOME/.local/bin
   ln -s /usr/bin/batcap $HOME/.local/bin/bat
fi
