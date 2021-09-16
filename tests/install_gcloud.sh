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
#	install_gcloudd.sh
#		Script that checks to see if the Google Cloud SDK is installed,
#		and if not, asks if it should be.
#
#	Usage:
#   	`bash ./install_gcloud.sh`
#
#	Source:
#   	[Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#	Authors:
#   	Cyriina Grimm <xxgrimmchildxx@gmail.com>
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
#             🌎☁️  Google Cloud  ☁️🌎              #
####################################################${NC}"
if type "gcloud" >/dev/null; then
	c_success "🌎☁️ Google Cloud SDK is already installed!"
fi
if ! type "gcloud" >/dev/null; then
	c_info "This step will instll GCloud stuff, which you'll need if you want the Docker install to complete successfully"
	c_question "Proceed? [y/n]"
	read gcloud_answer
	case "$gcloud_answer" in
	y | Y | yes | Yes)
		c_success "Working on it..."
		install_gcloud
		c_success "Done!"
		;;
	n | N | no | No)
		c_warning "Skipping GCloud installation"
		;;
	*)
		c_warning "Please respond with yes or no"
		;;
	esac
fi
