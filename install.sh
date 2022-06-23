#!/usr/bin/env zsh

# Copy VS Code settings
cp -r $HOME/.vscode $CODESPACE_VSCODE_FOLDER
cp -r .bin $HOME
cp .zshrc_append $HOME

# Make scripts executable
chmod 755 .bin/*

cat $HOME/.zshrc_append >> $HOME/.zshrc
