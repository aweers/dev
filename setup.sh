#!/usr/bin/env bash

dry_run="0"
if [[ $1 == "--dry" ]]; then
	echo "Dry run, not executing commands"
	dry_run="$1"
fi


update_config() {
	pushd $1 &> /dev/null
	(
		configs=`find . -mindepth 1 -maxdepth 1 -type d`
		for c in $configs; do
			directory=${2%/}/${c#./}
			echo "removing: rm -rf $directory"

			if [[ $dry_run == "0" ]]; then
				rm -rf $directory
			fi

			echo "copying env: cp $c $2"
			if [[ $dry_run == "0" ]]; then
				cp -r ./$c $2
			fi
		done
	)
	popd &> /dev/null
}

update_config configs ~/.config
