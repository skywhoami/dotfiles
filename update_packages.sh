#!/bin/bash
brew update && brew upgrade && brew cleanup && brew bundle dump --file=./Brewfile --force
nvim --headless "+MasonUpdate" +qall
nvim --headless "+Lazy! sync" +qa
