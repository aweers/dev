if ! command -v tmux 2>&1 >/dev/null; then
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		sudo apt install tmux
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		brew install tmux
	fi
fi

# Copy config files
src="./configs/tmux"
dest="$HOME/.tmux"

echo "Deleting $dest"
sudo rm -rf "$dest"

echo "Copying $src to $dest"
cp -r "$src" "$dest"

ln -s -f "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
cp "$HOME/.tmux/.tmux.conf.local" "$HOME/"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
