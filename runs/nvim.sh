if ! command -v nvim 2>&1 >/dev/null; then
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
		sudo rm -rf /opt/nvim
		sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		brew install neovim
	fi
fi

# Copy config files
src="./configs/nvim"
dest="$HOME/.config/nvim"

echo "Deleting $dest"
sudo rm -rf "$dest"

echo "Copying $src to $dest"
cp -r "$src" "$dest"
