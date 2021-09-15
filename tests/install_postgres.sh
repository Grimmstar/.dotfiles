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
# install_postgres.sh
#	Script that checks to see if PostgreSQL Database and the Postgresql CLI are installed,
#	and if not, asks if they should be.
#
# Usage:
#   `bash ./install_postgres.sh`
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
#          🐗 PostgreSQL & PostGres CLI 🐗           #
####################################################${NC}"
if type "psql" > /dev/null; then
    c_success "🐗 PostgreSQL & 🐗 PostGres CLI are already installed!"
fi
if ! type "psql" > /dev/null; then
    c_info "The 🐗 PostgreSQL database is one of the more popular options, and the 🐗 PostGres CLI makes it easier to interact with."
    c_question "Would you like to install the 🐗 PostgreSQL database & the 🐗 PostGres CLI? [y/n]"
    read psql_answer
    case "$psql_answer" in
	    y | Y | yes | Yes)
		    c_success "Installing 🐗 PostgreSQL..."
		    install_postgres
		    c_success "🐗 PostgreSQL has been installed!"
		    ;;
	    n | N | no | No)
    	    c_warning "Skipping 🐗 PostgreSQL installation"
		    ;;
	    *)
		    c_warning "Please respond with yes or no"
		    ;;
    esac
fi

