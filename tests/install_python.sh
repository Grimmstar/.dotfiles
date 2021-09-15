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
# install_python.sh
#    Script that checks to see if Python2 or Python3 is installed, and if not, asks if they
#    should be installed.
#
# Usage:
#   `bash ./install_python.sh`
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
#              🐍  Python 2 & 3  🐍               #
####################################################${NC}"
if type "pip" > /dev/null; then
	if type "pip3" > /dev/null; then
		c_success "🐍 Python is already installed! We can move on..."
	fi
fi
if ! type "pip" > /dev/null; then
	if ! type "pip3" > /dev/null; then
		c_info "Looks like 🐍 Python is missing..."
		c_question "Install 🐍 Python? [y/n]"
		read py_answer
		case "$py_answer" in
			y | Y | yes | Yes)
				c_success "Installing 🐍 Python..."
				install_python
				c_success "🐍 Python has been installed!"
				;;
			n | N | no | No)
    			c_warning "Skipping 🐍 Python installation"
				;;
			*)
				c_warning "Please respond with yes or no"
				;;
		esac
	fi
fi
