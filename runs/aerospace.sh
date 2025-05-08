src="./configs/aerospace"
dest="$HOME/.config/aerospace"

echo "Deleting $dest"
sudo rm -rf "$dest"

echo "Copying $src to $dest"
cp -r "$src" "$dest"
