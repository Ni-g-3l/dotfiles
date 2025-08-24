micro -v

tool_installed=$? 

if [ $tool_installed -ne 0 ]; then
	cd $HOME/.local/bin
	curl https://getmic.ro | bash
	cd -
fi

