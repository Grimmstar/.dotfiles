#!/bin/bash

source .dotfiles/utils/color_codes.sh
source .dotfiles/utils/logging_utils.sh

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)
  backup="."

  cd ~/.dotfiles/src/

  dotfilesDir=$(pwd)

  if [ -h ~/${1} ]; then
    # Existing symlink
    c_warning "Removing existing symlink: ${dest}"
    rm ${dest}

  elif [ -f "${dest}" ]; then
    # Existing file
    c_info "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    c_info "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  c_info "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
  c_success "New symlink created: ${dest}"
}

link_dotfiles .aliases
link_dotfiles .bash_profile
link_dotfiles .bash_prompt
link_dotfiles .bashrc
link_dotfiles .colors
link_dotfiles .curlrc
link_dotfiles .dircolors
link_dotfiles .editorconfig
link_dotfiles .env
link_dotfiles .exports
link_dotfiles .gitconfig
link_dotfiles .gitignore
link_dotfiles .npmrc
link_dotfiles .nvm
link_dotfiles .path
link_dotfiles .profile
link_dotfiles .ssh
link_dotfiles .tmux.config
# link_dotfiles .prompt
link_dotfiles .wgetrc
link_dotfiles colors.bash