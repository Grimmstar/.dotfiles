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
# install_aws.sh
#	Script that checks to see if the AWS (Amazon Web Service) is installed,
#	and if not, asks if it should be.
#
# Usage:
#   `bash ./install_aws.sh`
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
#             AWS (Amazon Web Service)             #
####################################################${NC}"
if type "aws" > /dev/null; then
	c_success "AWS is already installed!"
fi
if ! type "aws" > /dev/null; then
	c_info "This step will instll the AWS (Amazon Web Service) and CLI."
	c_question "Proceed? [y/n]"
	read aws_answer
	case "$aws_answer" in
		y | Y | yes | Yes)
			c_success "One moment..."
			install_aws
			c_success "Done!"
			;;
		n | N | no | No)
    		c_warning "Skipping AWS installation"
			;;
		*)
			c_warning "Please respond with yes or no"
			;;
	esac
fi