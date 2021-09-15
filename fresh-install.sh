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
# Fresh_Install
#    Installation script for a fresh Ubuntu setup. To run, use './fresh_install.sh'
#
# Source:
#   [Grimmstar's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
# Authors:
#   Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------
# Config
#    Using '-e' ensures the script will exit if it encounters an error.
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

show_header
# 3 seconds wait time to start the setup
for i in `seq 3 -1 1` ; do echo -ne "$i\rThe setup will start in... " ; sleep 1 ; done

echo -e "${BPurple}
####################################################
#${NC}                    ${BWhite}Pre-Config${NC}                    ${BPurple}#
####################################################${NC}"
sleep 1
c_info "We need to check some preliminary things before we can really get to work..."
sleep 1

# Create my own bin folder if it doesn't exist
[[ ! -d "${HOME}/bin" ]] && mkdir "${HOME}/bin"

# Create autostart folder if it doesn't exist
[[ ! -d "${HOME}/.config/autostart" ]] && mkdir -p "${HOME}/.config/autostart"

c_info "I believe we're ready to begin..."
sleep 2

echo -e "${BPurple}
####################################################
#${NC}              🌏  ${BWhite}3rd-party PPAs${NC}  🌏              ${BPurple}#
####################################################${NC}"
sleep 1
c_info "This step adds the private repositories for Ubuntu, Git, Docker, and NGINX so that we can be sure they are always the most up-to-date version."
sleep 1
c_question "Do you want to add the PPAs? [y/n]"
read ppa_answer
case "$ppa_answer" in
	y | Y | yes | Yes)
		c_hilight "Adding PPAs..."
		add_ppas
		c_success "PPA list is updated!"
		;;
	n | N | no | No)
		c_error "Skipping adding PPAs..."
		;;
	*)
		c_warning "Please respond with yes or no..."
		;;
esac
sleep 2

echo -e "${BPurple}
####################################################
#${NC}              💻  ${BWhite}System Update${NC}  💻               ${BPurple}#
####################################################${NC}"
sleep 1
c_info "Now running `apt update`, `apt upgrade`, and `apt autoremove`, which updates the system repositories, upgrades the system, and removes unnecessary or obsolete packages..."
update_system
c_success "System is up to date!"
sleep 2

echo -e "${BPurple}
####################################################
#${NC}           📦  ${BWhite}Package Installation${NC}  📦          ${BPurple}#
####################################################${NC}"
sleep 1
c_info "This step looks for a base packages list at ~/.dotfiles/utils/lists/packages.txt and installs those packages."
sleep 1
c_question "Do you want to install base packages? [y/n]"
read apt_answer
case "$apt_answer" in
	y | Y | yes | Yes)
		c_success "Installing packages..."
		install_packages
		;;
	n | N | no | No)
		c_warning "Skipping package installation"
		;;
	*)
		c_warning "Please respond with yes or no"
		;;
esac
sleep 2

echo -e "${BPurple}
####################################################
#${NC}              🚀  ${BWhite}Dev Libraries${NC}  🚀               ${BPurple}#
####################################################${NC}"
sleep 1
c_info "This step looks for a development packages list at ~/.dotfiles./utils/lists/dev_packages.txt and then installs those packages."
sleep 1
c_question "Do you want to install dev packages? [y/n]"
read dev_answer
case "$dev_answer" in
	y | Y | yes | Yes)
		c_success "Installing dev packages..."
		install_dev
		;;
	n | N | no | No)
		c_warning "Skipping dev package installation..."
		;;
	*)
		c_warning "Please respond with yes or no"
		;;
esac
sleep 2

c_info "Ensuring that we can communicate through the Windows network..."
windows

echo -e "${BPurple}
####################################################
#${NC}                 🔑 ${BWhite}SSH Keys${NC}  🔑                 ${BPurple}#
####################################################${NC}"
sleep 1
c_info "We need to check for SSH keys in ~/.ssh/id_rsa.pub, then generate one if it doesn't exist."
sleep 1
c_question "Check for keys? [y/n]"
read ssh_answer
case "$ssh_answer" in
	y | Y | yes | Yes)
		c_success "Installing SSH ..."
		install_ssh
		c_success "Creating keys ..."
		create_ssh_key
		c_success "Keys created! You need to add it to Github now..."
		test_ssh_key
		c_success "SSH setup is now complete..."
		;;
	n | N | no | No)
		c_warning "Skipping SSH installation"
		;;
	*)
		c_warning "Please respond with yes or no"
		;;
esac
sleep 2

echo -e "${BPurple}
####################################################
#${NC}                 💚  ${BWhite}Github${NC}  💚                   ${BPurple}#
####################################################${NC}"
sleep 1
if type "gh" > /dev/null; then
	c_success "💚 Github Cli is already installed!"
fi
if ! type "gh" > /dev/null; then
	c_info "Github Cli is not installed..."
	c_question "Would you like to install Github Cli? [y/n]"
	read gh_answer
	case "$gh_answer" in
		y | Y | yes | Yes)
			c_success "Working on it..."
			install_github
			github_shh
			c_success "Done!"
			;;
		n | N | no | No)
			c_warning "Skipping Github installation..."
			;;
		*)
			c_warning "Please respond with yes or no"
			;;
	esac
fi
sleep 2

echo -e "${BPurple}
####################################################
#${NC}               🐍  ${BWhite}Python 2 & 3${NC}  🐍               ${BPurple}#
####################################################${NC}"
sleep 1
if type "pip" > /dev/null; then
	if type "pip3" > /dev/null; then
		c_success "🐍 Python is already installed! We can move on..."
	fi
fi
if ! type "pip" > /dev/null; then
	if ! type "pip3" > /dev/null; then
		c_info "Looks like Python is missing..."
		c_question "Install Python? [y/n]"
		read py_answer
		case "$py_answer" in
			y | Y | yes | Yes)
				c_success "Installing Python..."
				install_python
				c_success "🐍 Python has been installed!"
				;;
			n | N | no | No)
				c_warning "Skipping 🐍 Python installation..."
				;;
			*)
				c_warning "Please respond with yes or no"
				;;
		esac
	fi
fi
sleep 2

echo -e "${BPurple}
####################################################
#${NC}        🧡  ${BWhite}NVM (Node Version Manager)${NC}  🧡        ${BPurple}#
####################################################${NC}"
sleep 1
if type "nvm" > /dev/null; then
    c_success "🧡 NVM is already installed!"
fi
if ! type "nvm" > /dev/null; then
    c_info "NVM (Node Version Manager) grants the ability to have multiple NodeJS versions installed, and manage them efficiently. It doesn't look like 🧡 NVM is currently installed..."
    sleep 2
	c_question "Would you like to install NVM and the latest LTS version of NodeJS? [y/n]"
    read node_answer
    case "$node_answer" in
		y | Y | yes | Yes)
			c_success "Installing NVM/Node..."
			install_node
			c_success "🧡 NVM/Node has been installed!"
			;;
		n | N | no | No)
			c_warning "Skipping 🧡 Node installation..."
			;;
	    *)
			c_warning "Please respond with yes or no"
			;;
    esac
fi
sleep 2

echo -e "${BPurple}
####################################################
#${NC}          🐗 ${BWhite}PostgreSQL & PostGres CLI${NC} 🐗         ${BPurple}#
####################################################${NC}"
sleep 1
if type "psql" > /dev/null; then
    c_success "🐗 PostgreSQL & 🐗 PostGres CLI are already installed!"
fi
if ! type "psql" > /dev/null; then
    c_info "The PostgreSQL database is one of the more popular options, and the PostGres CLI makes it easier to interact with."
    sleep 1
	c_question "Would you like to install the PostgreSQL database & the PostGres CLI? [y/n]"
    read psql_answer
    case "$psql_answer" in
	y | Y | yes | Yes)
		c_success "Working on it..."
		install_postgres
		c_success "🐗 PostgreSQL has been installed!"
		;;
	n | N | no | No)
		c_warning "Skipping 🐗 Postgres installation..."
		;;
	*)
		c_warning "Please respond with yes or no"
		;;
	esac
fi
sleep 2

echo -e "${BPurple}
####################################################
#${NC}              🌎☁️  ${BWhite}Google Cloud${NC}  ☁️🌎              ${BPurple}#
####################################################${NC}"
sleep 1
if type "gcloud" > /dev/null; then
    c_success "🌎☁️ Google Cloud SDK is already installed!"
fi
if ! type "gcloud" > /dev/null; then
	c_info "This step will instll GCloud stuff, which you'll need if you want the Docker install to complete successfully"
	sleep 1
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
sleep 2

echo -e "${BPurple}
####################################################
#${NC}         🐳  ${BWhite}Docker & Docker-Compose${NC}  🐳          ${BPurple}#
####################################################${NC}"
sleep 1
if type "docker" > /dev/null; then
	c_success "🐳 Docker is already installed!"
fi
if ! type "docker" > /dev/null; then
	c_info "This step will instll 🐳 Docker stuff, including  Docker-Compose"
	sleep 1
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
sleep 2

echo -e "${BPurple}
####################################################
#${NC}             ${BWhite}AWS (Amazon Web Service)${NC}             ${BPurple}#
####################################################${NC}"
sleep 1
if type "aws" > /dev/null; then
	c_success "AWS is already installed!"
fi
if ! type "aws" > /dev/null; then
	c_info "This step will instll the AWS (Amazon Web Service) and CLI."
	sleep 1
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
sleep 2

echo -e "${BPurple}
####################################################
#${NC}              ${BWhite}Heroku and Heroku CLI${NC}               ${BPurple}#
####################################################${NC}"
sleep 1
if type "heroku" > /dev/null; then
	c_success "Heroku is already installed!"
fi
if ! type "heroku" > /dev/null; then
	c_info "This step will instll Heroku and Heroku CLI."
	sleep 1
	c_question "Proceed? [y/n]"
	read heroku_answer
	case "$heroku_answer" in
		y | Y | yes | Yes)
			c_success "Okie dokie..."
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
sleep 2

echo -e "${BPurple}
####################################################
# ${NC}             ${BWhite}System Modifications${NC}                ${BPurple}#
####################################################${NC}"
sleep 1
c_info "Now that everything is installed as far as programs go, it's time to customize the system..."
sleep 1
c_question "Do you want to install allow these mods? [y/n]"
read mods_answer
	case "$mods_answer" in
		y | Y | yes | Yes)
			c_success "I'm on it..."
			system_mods
			auto_start
			c_success "Done!"
			;;
		n | N | no | No)
			c_warning "Skipping system modification"
			;;
		*)
			c_warning "Please respond with yes or no"
			;;
	esac
sleep 2

echo -e "${BPurple}
####################################################
#${NC}              ${BWhite}Dotfiles and Configs${NC}                ${BPurple}#
####################################################${NC}"
sleep 1
c_info "It's time to copy over our personal dotfiles and configs, and create symlinks and backups..."
sleep 1
c_question "Do you want to allow these mods? [y/n]"
read dotfiles_answer
	case "$dotfiles_answer" in
		y | Y | yes | Yes)
			c_success "Please tell me we're almost done..."
			link_dotfiles .aliases
			link_dotfiles .bash_profi
			link_dotfiles .bash_promp
			link_dotfiles .bashrc
			link_dotfiles .colors
			link_dotfiles .curlrc
			link_dotfiles .dircolors
			link_dotfiles .editorconf
			link_dotfiles .env
			link_dotfiles .exports
			link_dotfiles .gitconfig
			link_dotfiles .gitignore
			link_dotfiles .npmrc
			link_dotfiles .nvm
			link_dotfiles .path
			link_dotfiles .profile
			link_dotfiles .ssh
			link_dotfiles .tmux.confi
			# link_dotfiles .prompt
			link_dotfiles .wgetrc
			link_dotfiles colors.bash
			c_success "Finally!"
			;;
		n | N | no | No)
			c_warning "Skipping dotfiles modification"
			;;
		*)
			c_warning "Please respond with yes or no"
			;;
	esac


sleep 5
c_success "That's it, we've finished everything on the list!"
sleep 2
figlet "Things are set up just the way you like them. You're welcome, lazy human!" | lolcat
sleep 5

