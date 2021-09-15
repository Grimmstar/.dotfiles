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
#    logging_utils.sh
#        File that can be sourced from a script to colorize output.
#
#    Source:
#       [Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#    Authors:
#       Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------

source .dotfiles/utils/color_codes.sh

set -e

echo ''

c_info () {
  printf "\n ⭐${BGrey} %s${NC}\n" "$@"
  sleep 1
}

c_question () {
  printf "\n ❔${BCyan} %s${NC}\n" "$@"
  sleep 1
}

c_success () {
  printf "\n ✔️ ${BGreen} %s${NC}\n" "$@"
  sleep 1
}

c_error () {
  printf "\n ❌ ${Red} %s${NC}\n" "$@"
  sleep 1
}

c_warning () {
  printf "\n ⚠️ ${BYellow} %s${NC}\n" "$@"
  sleep 1
}

c_install () {
  printf "\n 🚧 ${Grey} %s${NC}\n" "$@"
}

c_hilight (){
  printf "${LightPurple} %s${NC}" "$@"
}

# header() {
#   printf "\r [ ${bold}${purple} ] $1\n ${reset}\n" "$@"
# }

# info () {
#   printf "\r  [ \033[00;34m..\033[0m ] $1\n"
# }

# user () {
#   printf "\r  [ \033[0;33m??\033[0m ] $1\n"
# }

# success () {
#   printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
# }

# fail () {
#   printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
#   echo ''
#   exit
# }

# e_arrow() { printf "➜ $@\n"
# }
# e_success() { printf "${green}✔ %s${reset}\n" "$@"
# }
# e_error() { printf "${red}✖ %s${reset}\n" "$@"
# }
# e_warning() { printf "${tan}➜ %s${reset}\n" "$@"
# }
# e_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
# }
# e_bold() { printf "${bold}%s${reset}\n" "$@"
# }
# e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
# }
