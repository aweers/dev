if command -v nvim >/dev/null 2>&1; then
  echo "nvim is available as a command"
elif [ -x "/opt/nvim-linux-x86_64/bin/nvim" ]; then
  echo "nvim is available at the aliased path"
else
  echo "nvim is not available"
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
		sudo rm -rf /opt/nvim
		sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
		rm nvim-linux-x86_64.tar.gz
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
