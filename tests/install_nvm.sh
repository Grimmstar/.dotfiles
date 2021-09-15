#!/usr/bin/env bash
#---------------------------------------------------------------------------------------------
#
#  ██████╗ ██████╗ ██╗███╗   ███╗███╗   ███╗███████╗████████╗ █████╗ ██████╗
# ██╔════╝ ██╔══██╗██║████╗ ████║████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
# ██║  ███╗██████╔╝██║██╔████╔██║██╔████╔██║███████╗   ██║   ███████║██████╔╝
# ██║   ██║██╔══██╗██║██║╚██╔╝██║██║╚██╔╝██║╚════██║   ██║   ██╔══██║██╔══██╗
# ╚██████╔╝██║  ██║██║██║ ╚═╝ ██║██║ ╚═╝ ██║███████║   ██║   ██║  ██║██║  ██║
#  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
#
#---------------------------------------------------------------------------------------------
#
# install_nvm.sh
#	Script that checks to see if NVM (Node Version Manager) or NodeJS is installed, and if
#	not, asks if they should be installed. If yes, the latest LTS version of NodeJS is
#	installed
#
# Usage:
#   `bash ./install_nvm.sh`
#
# Source:
#   [Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
# Authors:
#   Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------
set -e
set -o pipefail

source $(dirname $0)/utils/color_codes.sh
source $(dirname $0)/utils/logging_utils.sh
source $(dirname $0)/utils/functions.sh

traperr() {
  echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

#---------------------------------------------------------------------------------------------
# Script

echo -e "${BPurple}
####################################################
#        🧡  NVM (Node Version Manager)  🧡       #
####################################################${NC}"
if type "nvm" > /dev/null; then
    c_success "🧡 NVM is already installed!"
fi
if ! type "nvm" > /dev/null; then
    c_info "🧡 NVM (Node Version Manager) grants the ability to have multiple 🧡 NodeJS versions installed, and manage them efficiently. It doesn't look like 🧡 NVM is currently installed..."
    c_question "Would you like to install 🧡 NVM and the latest LTS version of 🧡 NodeJS? [y/n]"
    read node_answer
    case "$node_answer" in
	    y | Y | yes | Yes)
		    c_success "Installing 🧡 NVM/Node..."
		    install_node
		    c_success "🧡 NVM/Node has been installed!"
		    ;;
	    n | N | no | No)
    	    c_warning "Skipping 🧡 Node installation"
		    ;;
	    *)
		    c_warning "Please respond with yes or no"
		    ;;
    esac
fi

