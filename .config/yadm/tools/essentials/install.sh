sudo apt install build-essential git git-lfs curl xclip net-tools

cargo -V 
tool_installed=$?
if [ $tool_installed != 0 ]; then
    curl https://sh.rustup.rs -sSf | sh
fi

v --version
v_installed=$?
if [ $v_installed != 0 ]; then 
	git clone --depth=1 https://github.com/vlang/v $HOME/.v
	cd $HOME/.v
	make
	sudo ./v symlink
	cd -
fi
