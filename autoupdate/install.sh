#!/bin/sh
# setups the auto-update if crontab is available
if command -v crontab >/dev/null 2>&1; then
	(
		crontab -l | grep -v "dot_update"
		echo "0 */2 * * * $HOME/.dotfiles/bin/dot_update > ${TMPDIR:-/tmp}/dot_update.log 2>&1"
	) | crontab -
fi

