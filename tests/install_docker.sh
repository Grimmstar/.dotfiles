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
# install_docker.sh
#	Script that checks to see if Docker and Docker-Compose are installed,
#	and if not, asks if they should be.
#
# Usage:
#   `bash ./install_docker.sh`
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
#         🐳  Docker & Docker-Compose  🐳         #
####################################################${NC}"
if type "docker" > /dev/null; then
	c_success "🐳 Docker is already installed!"
fi
if ! type "docker" > /dev/null; then
	c_info "This step will instll 🐳 Docker stuff, including 🐳 Docker-Compose"
	c_question "Proceed? [y/n]"
	read docker_answer
	case "$docker_answer" in
		y | Y | yes | Yes)
			c_success "Doing the things..."
			install_docker
			c_success "Done!"
			;;
		n | N | no | No)
    		c_warning "Skipping 🐳 Docker installation"
			;;
		*)
			c_warning "Please respond with yes or no"
			;;
	esac
fi