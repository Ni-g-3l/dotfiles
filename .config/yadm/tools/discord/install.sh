discord -h > /dev/null 2> /dev/null
tool_install=$?

if [ $tool_install -ne 0 ]; then
   curl -Lo discord.deb https://discord.com/api/download?platform=linux
   sudo dpkg -i discord.deb
   rm discord.deb
fi

