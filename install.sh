#!/bin/sh

if [ ! "$CODESPACES" = "true" ]; then
	exit 0
fi

DOTFILES_PATH=/workspaces/.codespaces/.persistedshare/dotfiles

configure_shell() {
	if [ ! -f "$DOTFILES_PATH/.zshrc" ]; then
		return
	fi;

	echo "Configuring shell"
	
	cat $DOTFILES_PATH/.zshrc > $HOME/.zshrc
}

configure_codespaces() {
	PROJECT_PATH=$DOTFILES_PATH/codespaces-project-config/$GITHUB_REPOSITORY

	if [ ! -d "$PROJECT_PATH" ]; then
		return
	fi;

	echo "Syncing project files"

	# Copy any changes from PROJECT_PATH to the workspace folder (without deleting anything)
	rsync --archive $PROJECT_PATH/ .
}

configure_bin() {
	PROJECT_PATH=$DOTFILES_PATH/codespaces-project-config/$GITHUB_REPOSITORY

	if [ ! -d "$DOTFILES_PATH/bin" ]; then
		return
	fi;

	echo "Syncing scripts"

	# Make scripts executable
	chmod 755 $DOTFILES_PATH/bin/*

	# Copy scripts to home dir
	rsync --archive $DOTFILES_PATH/bin/ $HOME/bin

	echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.zshrc
}

configure_shell

configure_bin

configure_codespaces
