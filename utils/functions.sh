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
#	functions.sh
#		Functions for a fresh Ubuntu setup. Used with './fresh_install.sh'
#
#	Source:
#   	[Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#	Authors:
#   	Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------

#	Sources

source $(dirname $0)/utils/color_codes.sh
source $(dirname $0)/utils/logging_utils.sh

#	Variables

DOTFILES="~/.dotfiles"
DOTFILES_SOURCE="$(dirname $0)/src"
DOTFILES_UTILS="$(dirname $0)/utils"
DOTFILES_LISTS="${DOTFILES_UTILS}/lists/"
FONTS_DIR="$(dirname $0)/bin/.local/fonts"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date "+%Y%m%d%H%M.%S")"

dest="${HOME}/${1}"
old=".OLD"

#	Functions

function show_header() {
	cat <<"HEADER"

  ██████╗ ██████╗ ██╗███╗   ███╗███╗   ███╗███████╗████████╗ █████╗ ██████╗
 ██╔════╝ ██╔══██╗██║████╗ ████║████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
 ██║  ███╗██████╔╝██║██╔████╔██║██╔████╔██║███████╗   ██║   ███████║██████╔╝
 ██║   ██║██╔══██╗██║██║╚██╔╝██║██║╚██╔╝██║╚════██║   ██║   ██╔══██║██╔══██╗
 ╚██████╔╝██║  ██║██║██║ ╚═╝ ██║██║ ╚═╝ ██║███████║   ██║   ██║  ██║██║  ██║
  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
                                         Automated techno alchemy by Cyriina
HEADER
}

function add_ppas() {
	##	Git
	sudo add-apt-repository ppa:git-core/ppa -y
	##	Github
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
	sudo apt-add-repository https://cli.github.com/packages
	##	NGINX
	sudo add-apt-repository ppa:ondrej/nginx -y
	##	PostGreSQL
	curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
	##	Docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	##	Ubuntu Universe
	sudo add-apt-repository universe
}

function update_system() {
	sudo apt-get update && sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	sudo apt autoremove -y
}

function install_packages() {
	##	Looks for a list of default packages to install
	if [ -f "${DOTFILES_LISTS}/packages.txt" ]; then
		c_success "Found Packages list. Installing..."
		for i in $(cat ${DOTFILES_LISTS}/packages.txt); do
			if ! dpkg-query -W -f='${Status} ${Version}\n' ${i} | grep "^install ok" >/dev/null; then
				c_install "Installing package ${i} "
				sudo apt-get install -y ${i}
			else
				c_success "Package ${i} is already installed. Skipping..."
			fi
		done
	else
		c_error "No Packages file found. Skipping package installation..."
	fi
}

function install_dev() {
	##	Looks for a list of development packages to install
	if [ -f "${DOTFILES_LISTS}/dev_packages.txt" ]; then
		c_success "Found dev list. Installing..."
		for i in $(cat ${DOTFILES_LISTS}/dev_packages.txt); do
			if ! dpkg-query -W -f='${Status} ${Version}\n' ${i} | grep "^install ok" >/dev/null; then
				c_install "Installing package ${i} "
				sudo apt-get install -y ${i}
			else
				c_success "Package ${i} is already installed. Skipping..."
			fi
		done
	else
		c_error "No dev packages file found. Skipping dev installation..."
	fi
}

function windows() {
	#	Install Winbind and it's support lib to ping WINS hosts
	sudo apt install -y winbind libnss-winbind
	#	Need to edit the /etc/nsswitch.conf file to enable if not already done ...
	if ! grep -qc 'wins' /etc/nsswitch.conf; then
		sudo sed -i '/hosts:/ s/$/ wins/' /etc/nsswitch.conf
	fi
}

function install_github() {
	##	Installs the Github CLI, then checks for a config file. Removes the old file, and symlinks the one from this repository
	sudo apt install gh
	test -L ${HOME}/.config/gh || rm -rf ${HOME}/.config/gh
	ln -vsfn ${DOTFILES_UTILS}/github/config.txt ${HOME}/.config/gh
}

function install_ssh() {
	##	Removes default SSH and re-installs it, then starts the service
	sudo apt remove -y openssh-server
	sudo apt install -y openssh-server
	sudo service ssh start
	##	Modify firewall rules to allow SSH through
	sudo ufw allow ssh
	sudo ufw enable
	sudo ufw status
	##	Looks for config and HOSTS files, then symlinks them
	if [ -d ${DOTFILES_UTILS}/ssh ]; then
		ln -vsf ${DOTFILES_UTILS}/ssh/config ${HOME}/.ssh/config
		ln -vsf ${DOTFILES_UTILS}/ssh/known_hosts ${HOME}/.ssh/known_hosts
	fi
	##	Setup keyrings
	mkdir -p ${HOME}/.local/share
	test -L ${HOME}/.local/share/keyrings || rm -rf ${HOME}/.local/share/keyrings
	ln -vsfn ${HOME}/backup/keyrings ${HOME}/.local/share/keyrings
	## Installs and sets up Homebrew, so we can use Shellenv
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
	test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
	test -d /home/linuxbrew/.linuxbrew && eval $(${HOME}/linuxbrew/.linuxbrew/bin/brew shellenv)
	test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
	##	Certificate creation
	brew install mkcert nss
	mkcert -install
	mkcert localhost
}

function seek_confirmation() {
	##	Function to ask for user input to questions
	c_info "$@"
	while true; do
		read -p " [y/n] " confirmation
		case $confirmation in
		[Yy]*) return 0 ;;
		[Nn]*) return 1 ;;
		*) input "Please answer yes or no." ;;
		esac
	done
}

function create_ssh_key() {
	##	Checks for existing keys, creates them if there aren't any. Copies key to clipboard to be pasted into Github browser
	if ! [ -f "${HOME}/.ssh/id_rsa.pub" ]; then
		ssh-keygen -t rsa
	fi
	c_info "Copying public key to clipboard..."
	if [ -f "${HOME}/.ssh/id_rsa.pub" ]; then
		pbcopy <"${HOME}/.ssh/id_rsa.pub"
	fi
}

function test_ssh_key() {
	## Connects key to Github and tests to see if it works
	ready=false
	while [ "$ready" != true ]; do
		if seek_confirmation "Ready to paste SSH key to Github?"; then
			ready=true
			open https://github.com/account/ssh
		fi
	done
	ready=false
	while [ "$ready" != true ]; do
		if seek_confirmation "Ready to test the key?"; then ready=true; fi
	done
	c_info "Confirming the SSH key works..."
	ready=false
	while [ "$ready" != true ]; do
		ssh -T git@github.com
		# SSH returns a status of '1' when the command works and a status
		# of '255' when it doesn't. So, we check for a status of less then 2
		if [ $? -lt 2 ]; then
			ready=true
			c_success "Congrats. You can now SSH to Github"
		else
			if seek_confirmation "$?: Key didn't work. Test again?"; then
				continue
			else
				c_error "Can't continue without Github working. Skipping."
			fi
		fi
	done
}

function install_python() {
	##	Installs both Python 2.7 and 3.9, and sets up auto env with default packages
	curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
	git clone git://github.com/yyuu/pyenv-pip-migrate.git ~/.pyenv/plugins/pyenv-pip-migrate
	git clone https://github.com/yyuu/pyenv-ccache.git ~/.pyenv/plugins/pyenv-ccache
	git clone https://github.com/jawshooah/pyenv-default-packages.git ~/.pyenv/plugins/pyenv-default-packages

	if [ -f ${DOTFILES_UTILS}/python/default_packages.txt ]; then
		cp ${DOTFILES_UTILS}/python/default_packages.txt ~/.pyenv/default-packages
	fi

	if ! grep -qc 'pyenv init' ~/.bashrc; then
		echo "Adding pyenv to .bashrc"
		echo >>~/.bashrc
		echo "# Set up Pyenv" >>~/.bashrc
		echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
		echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
		echo 'eval "$(pyenv init --path)"' >>~/.bashrc
		echo 'eval "$(pyenv init -)"' >>~/.bashrc
		echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc
	fi
	##	Run the above locally to use in this shell
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"

	c_info "Installing Python versions..."
	pyenv install 2.7.18
	pyenv install 3.9.6
	##	'python' and 'python3' target 3.9.6 while 'python2' targets 2.7.18
	pyenv global 3.9.6 2.7.18
	##	Now update 'pip' in both versions ...
	c_info "Upgrading Pip..."
	python2 -m pip install --upgrade pip
	python3 -m pip install --upgrade pip
}

function install_node() {
	##	Installs NVM to allow for multiple NodeJS versions to be installed
	echo >>~/.bashrc
	echo "# Set up NVM" >>~/.bashrc
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                 # This loads nvm
	[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion # This loads nvm bash_completion

	##	Check for a default packages list to install with every project
	if [ -f ${DOTFILES_UTILS}/nvm/default_packages.txt ]; then
		cp ${DOTFILES_UTILS}/nvm/default_packages.txt ~/.nvm/default-packages
	fi

	nvm install --lts
	nvm install node
	nvm use --lts
}

function install_postgres() {
	##	Installs PostGreSQL, creates a user, and sets up backups
	sudo apt-get install -y postgresql
	cd /home
	sudo -u postgres initdb -E UTF8 --no-locale -D '/var/lib/postgres/data'
	sudo systemctl start postgresql.service
	cd /home
	sudo -u postgres createuser --interactive
	mkdir -p ${HOME}/.backups
	pip install --user pgcli
	test -L ${HOME}/.config/pgcli || rm -rf ${HOME}/.config/pgcli
	ln -vsfn ${HOME}/.backups/pgcli ${HOME}/.config/pgcli
}

function install_gcloud() {
	##	Installs the Google Cloud SDK and symlinks the config file
	curl https://sdk.cloud.google.com | bash
	test -L ${HOME}/.config/gcloud || rm -rf ${HOME}/.config/gcloud
	ln -vsfn ${DOTFILES_UTILS}/gcloud/config.txt ${HOME}/.config/gcloud
}

function install_docker() {
	##	Installs Docker and Docker Compose, creates the docker user, and enables the service
	sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common docker-ce docker-ce-cli containerd.io
	sudo groupadd docker
	sudo usermod -a -G docker ${USER}
	mkdir -p ${HOME}/.docker
	ln -vsf ${PWD}/.docker/config.json ${HOME}/.docker/config.json
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo apt-get install -y docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	gcloud components install docker-credential-gcr
}

function install_aws() {
	##	Installs the AWS Cli and symlinks the config files
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	test -L ${HOME}/.aws || rm -rf ${HOME}/.aws
	ln -vsfn ${PWD}/.aws ${HOME}/.aws
	rm -fr awscliv2.zip
	rm -rf aws
}

function install_heroku() {
	## Installs the Heroku CLI
	curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
	heroku login
}

function system_mods() {
	##	Set up .dircolors for file system differentiation
	wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O ${HOME}/.dircolors

	##	Set up custom fonts
	if [ is_wsl ]; then
		mkdir -p "${FONTS_DIR}"
		cd "${FONTS_DIR}"
		if [ ! find . -name 'Fira*' -printf 1 -quit | grep -q 1 ]; then
			url='https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip'
			wget -O font.zip "${url}"
			unzip -o font.zip
			rm font.zip
			find . -iname "Fura*" -delete
			find . -iname "Fira*.ttf" -delete
			find . -iname "Fira*Windows Compatible*" -delete
		fi

		sudo dnf install google-roboto-fonts

		fc-cache -fv "${FONTS_DIR}"
		cd - >/dev/null
		mkdir -p ${FONTS_DIR}/powerline/
		cd ${FONTS_DIR}/powerline/
		rm -rf fonts
		git clone git@github.com:powerline/fonts.git
		cd fonts
		./install.sh
	fi
}

function link_dotfiles() {
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

function auto_start() {
	mkdir -p ${HOME}/.local
	cp $(dirname $0)/bin/start_services.sh ${HOME}/.local
	chmod +x ${HOME}/.local/bin/start_services.sh
}
