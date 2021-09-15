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
# install_heroku.sh
#	Script that checks to see if Heroku and Heroku CLI are installed,
#	and if not, asks if they should be.
#
# Usage:
#   `bash ./install_heroku.sh`
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
#              Heroku and Heroku CLI               #
####################################################${NC}"
if type "heroku" > /dev/null; then
	c_success "Heroku is already installed!"
fi
if ! type "heroku" > /dev/null; then
	c_info "This step will instll Heroku and Heroku CLI."
	c_question "Proceed? [y/n]"
	read heroku_answer
	case "$heroku_answer" in
		y | Y | yes | Yes)
			c_success "One moment..."
			install_heroku
			c_success "Done!"
			;;
		n | N | no | No)
    		c_warning "Skipping Heroku installation"
			;;
		*)
			c_warning "Please respond with yes or no"
			;;
	esac
fi