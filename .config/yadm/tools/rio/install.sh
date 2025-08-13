rio -V 
tool_installed=$?

if [ $tool_installed != 0 ]; then
    RIO_VERSION=$(curl -s "https://api.github.com/repos/raphamorim/rio/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo rioterm_${RIO_VERSION}_amd64_x11.deb https://github.com/raphamorim/rio/releases/download/v${RIO_VERSION}/rioterm_${RIO_VERSION}_amd64_x11.deb
    sudo dpkg -i rioterm_${RIO_VERSION}_amd64_x11.deb
    rm rioterm_${RIO_VERSION}_amd64_x11.deb
fi
