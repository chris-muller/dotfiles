#!/bin/sh

cat .zshrc > $HOME/.zshrc

configure_codespaces() {
	if [ ! "$CODESPACES" = "true" ]; then
		return
	fi

	# Configure .vscode folder
	PROJECT_PATH=codespaces-project-config/$GITHUB_REPOSITORY

	# If folder matching current project exists, sync files across to project root 
	if [[ -d $PROJECT_PATH ]]; then
		# Copy any changes from PROJECT_PATH to WORKSPACE_FOLDER (without deleting anything in WORKSPACE_FOLDER)
		rsync --archive $PROJECT_PATH $WORKSPACE_FOLDER
	fi;
}

configure_bin() {
	# Make scripts executable
	chmod 755 bin/*

	# Copy scripts to home dir
	rsync --archive bin $HOME/bin

	export PATH="$HOME/bin:$PATH"
}

configure_bin

configure_codespaces
