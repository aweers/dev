#!/usr/bin/env bash

create_symlink() {
	local source_path="$1"
	local target_path="$2"

	echo "Attempting to link: $source_path -> $target_path"

	# Check if the source exists
	if [ ! -e "$source_path" ]; then
		echo "Error: Source does not exist: $source_path"
		return 1
	fi

	# Create parent directory if it doesn't exist for the target
	local target_dir=$(dirname "$target_path")
	if [ ! -d "$target_dir" ]; then
		echo "Creating directory: $target_dir"
		mkdir -p "$target_dir" || {
			echo "Error: Failed to create directory $target_dir"
			return 1
		}
	fi

	# Remove existing link/file/directory at the target path
	if [ -L "$target_path" ]; then
		echo "Removing existing symlink: $target_path"
		rm "$target_path"
	elif [ -d "$target_path" ]; then
		echo "Warning: Directory already exists at $target_path. Backing up and replacing."
		mv "$target_path" "$target_path.bak.$(date +%Y%m%d%H%M%S)"
	elif [ -f "$target_path" ]; then
		echo "Warning: File already exists at $target_path. Backing up and replacing."
		mv "$target_path" "$target_path.bak.$(date +%Y%m%d%H%M%S)"
	fi

	# Create the symbolic link
	ln -s "$source_path" "$target_path"
	if [ $? -eq 0 ]; then
		echo "Successfully linked: $target_path"
	else
		echo "Error: Failed to create symlink for $target_path"
		return 1
	fi
}

# Argument parsing
# First argument is path to dotfiles dir
# Additional arguments specify which configs to link
DOTFILES_DIR=$(cd "$1" && pwd -P)
if [ $? -ne 0 ]; then
	echo "Error: Could not resolve absolute path for $1. Does it exist?"
	exit 1
fi
shift

commands=()
while [[ $# -gt 0 ]]; do
	case "$1" in
	-*)
		echo "Unknown option: $1"
		exit "$1"
		;;
	*)
		commands+=("$1")
		shift
		;;
	esac
done

echo "Starting dotfiles linking process..."
echo "Dotfiles directory: $DOTFILES_DIR"

mkdir -p "$HOME/.config"

for cmd in "${commands[@]}"; do
	case "$cmd" in
	"zsh")
		create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
		;;
	"tmux")
		create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
		create_symlink "$DOTFILES_DIR/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
		create_symlink "$DOTFILES_DIR/tmux/tmux.remote.conf" "$HOME/.config/tmux/tmux.remote.conf"
		;;
	"git")
		GIT_ALIASES_TARGET="$HOME/.config/git/aliases"
		create_symlink "$DOTFILES_DIR/git/aliases" "$GIT_ALIASES_TARGET"
		echo ""
		echo "--- IMPORTANT GIT CONFIGURATION STEP ---"
		echo "Your Git aliases from dotfiles have been linked to: $GIT_ALIASES_TARGET"
		echo "Please ensure your main ~/.gitconfig file contains the following lines:"
		echo ""
		echo "  [include]"
		echo "      path = $GIT_ALIASES_TARGET"
		echo ""
		echo "You can open it with: nvim ~/.gitconfig"
		echo "----------------------------------------"
		;;
	"nvim")
		create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
		;;
	"aerospace")
		create_symlink "$DOTFILES_DIR/aerospace" "$HOME/.config/aerospace"
		;;
	*)
		echo "Unknown install command: <$cmd>"
		;;
	esac
done
