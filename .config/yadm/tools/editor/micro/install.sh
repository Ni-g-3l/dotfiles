micro -v

tool_installed=$? 

if [ $tool_installed -ne 0 ]; then
	curl https://getmic.ro | bash
	mv micro ~/.local/bin/
fi

