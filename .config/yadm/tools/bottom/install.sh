btm -V
installed=$?

if [ $installed != 0 ]; then
	cargo install bottom --locked
fi
