sudo apt install build-essential

sudo apt-get install curl
sudo apt-get install xclip

cargo -V 
tool_installed=$?
if [ $tool_installed != 0 ]; then
    curl https://sh.rustup.rs -sSf | sh
fi

fzf --version
tool_installed=$?
if [ $tool_installed != 0 ]; then
    sudo apt install fzf
fi

rg --version
tool_installed=$?
if [ $tool_installed != 0 ]; then
    sudo apt-get install ripgrep
fi

