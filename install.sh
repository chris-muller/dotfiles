#!/bin/sh

cat .zshrc > $HOME/.zshrc

configure_codespaces() {
	if [ ! "$CODESPACES" = "true" ]; then
		return
	fi

	echo "Configuring codespace"

	# Configure .vscode folder
	PROJECT_PATH=codespaces-project-config/$GITHUB_REPOSITORY

	# If folder matching current project exists, sync files across to project root 
	if [[ -d $PROJECT_PATH ]]; then
		# Copy any changes from PROJECT_PATH to WORKSPACE_FOLDER (without deleting anything in WORKSPACE_FOLDER)
		ln -s FolderA FolderB
		rsync --archive --ignore-times $PROJECT_PATH $WORKSPACE_FOLDER
	fi;
}

configure_bin() {

	echo "Configuring bin scripts"

	# Make scripts executable
	chmod 755 bin/*

	mkdir -p $HOME/bin

	# Copy scripts to home dir
	rsync --archive --ignore-times bin $HOME/bin

	export PATH="$HOME/bin:$PATH"
}

configure_bin

configure_codespaces
