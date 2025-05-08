#!/usr/bin/env bash

dry_run=false
commands=()
while [[ $# -gt 0 ]]; do
	case "$1" in
	--dry)
		dry_run=true
		shift
		;;
	-*)
		echo "Unknown option: $1"
		exit $1
		;;
	*)
		commands+=("$1")
		shift
		;;
	esac
done

if $dry_run; then
	echo "Dry run, not executing commands"
fi

run_commands() {
	echo "Running commands for $1"
	src="./runs/$1.sh"

	if [[ -f "$src" ]]; then
		$src
	else
		echo "No commands found for $1, skipping"
	fi
}

update_config() {
	echo "Processing: $1"
	src="./configs/$1"
	dest="$HOME/.config/$1"

	if [[ -d "$src" ]]; then
		echo "Found: $src"
		if $dry_run; then
			echo "[Dry-run] Would delete $dest"
			echo "[Dry-run] Would copy $src to $dest"
		else
			echo "Deleting $dest"
			rm -rf "$dest"

			echo "Copying $src to $dest"
			cp -r "$src" "$dest"
		fi
	else
		echo "Did not find: $src"
	fi
}

for cmd in "${commands[@]}"; do
	run_commands $cmd
done
