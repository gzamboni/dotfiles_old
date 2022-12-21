#!/bin/sh
if command -v code >/dev/null; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi
	mkdir -p "$VSCODE_HOME/User"

	ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
	ln -sf "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User/snippets"

	EXTENSION_LIST=$(code --list-extensions)

	while read -r module; do
		# check if the extension is already installed if not install it
		if [[ ! $EXTENSION_LIST =~ $module ]]; then
			code --install-extension "$module"
		fi
	done <"$DOTFILES/vscode/extensions.txt"
fi
