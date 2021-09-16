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

source $(dirname $0)/utils/color_codes.sh

set -e

echo ''

c_info() {
  printf "\n ⭐${BGrey} %s${NC}\n" "$@"
  sleep 1
}

c_question() {
  printf "\n ❔${BCyan} %s${NC}\n" "$@"
  sleep 1
}

c_success() {
  printf "\n ✔️ ${BGreen} %s${NC}\n" "$@"
  sleep 1
}

c_error() {
  printf "\n ❌ ${Red} %s${NC}\n" "$@"
  sleep 1
}

c_warning() {
  printf "\n ⚠️ ${BYellow} %s${NC}\n" "$@"
  sleep 1
}

c_install() {
  printf "\n 🚧 ${Grey} %s${NC}\n" "$@"
}

c_hilight() {
  printf "${LightPurple} %s${NC}" "$@"
}
