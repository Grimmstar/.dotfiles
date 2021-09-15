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
#   Color Codes
#       A list that can be sourced and used for scripting purposes.
#
#   Source:
#       [Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#   Authors:
#       Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------

# Reset
NC='\033[0m'                    # Text Reset

# Regular Colors
Black='\033[0;30m'              # Black
White='\033[0;37m'              # White
Red='\033[0;31m'                # Red
Orange='\033[0;38;5;214m'       # Orange
Yellow='\033[0;38;5;227m'       # Yellow
Green='\033[0;32m'              # Green
Cyan='\033[0;38;5;51m'          # Cyan
Blue='\033[0;38;5;33m'          # Blue
Purple='\033[0;38;5;105m'       # Purple
LightPurple='\033[0;38;5;177m'  # Light Purple
Pink='\033[0;38;5;200m'         # Pink
Grey='\033[0;38;5;246m'         # Grey

# Bold
BBlack='\033[1;30m'             # Black
BWhite='\033[1;37m'             # White
BRed='\033[1;31m'               # Red
BOrange='\033[1;38;5;214m'      # Orange
BYellow='\033[1;38;5;227m'      # Yellow
BGreen='\033[1;32m'             # Green
BCyan='\033[1;38;5;51m'         # Cyan
BBlue='\033[1;38;5;33m'         # Blue
BPurple='\033[1;38;5;105m'      # Purple
BLightPurple='\033[1;38;5;177m' # Light Purple
BPink='\033[1;38;5;200m'        # Pink
BGrey='\033[1;38;5;246m'        # Grey

# Underline
UBlack='\033[4;30m'             # Black
UWhite='\033[4;37m'             # White
URed='\033[4;31m'               # Red
UOrange='\033[4;38;5;214m'      # Orange
UYellow='\033[4;38;5;227m'      # Yellow
UGreen='\033[4;32m'             # Green
UCyan='\033[4;38;5;51m'         # Cyan
UBlue='\033[4;38;5;33m'         # Blue
UPurple='\033[4;38;5;105m'      # Purple
ULightPurple='\033[4;38;5;177m' # Light Purple
UPink='\033[4;38;5;200m'        # Pink
UGrey='\033[4;38;5;246m'        # Grey

# Background
On_Black='\033[40m'             # Black
On_White='\033[47m'             # White
On_Red='\033[41m'               # Red
On_Orange='\033[214m'           # Orange
On_Yellow='\033[43m'            # Yellow
On_Green='\033[42m'             # Green
On_Cyan='\033[46m'              # Cyan
On_Blue='\033[44m'              # Blue
On_Purple='\033[45m'            # Purple
On_LightPurple='\033[177m'      # Light Purple
On_Pink='\033[200m'             # Pink
On_Grey='\033[246m'             # Grey

# High Intensity
IBlack='\033[0;90m'             # Black
IWhite='\033[0;97m'             # White
IRed='\033[0;91m'               # Red
IOrange='\033[0;214m'           # Orange
IYellow='\033[0;93m'            # Yellow
IGreen='\033[0;92m'             # Green
ICyan='\033[0;96m'              # Cyan
IBlue='\033[0;94m'              # Blue
IPurple='\033[0;95m'            # Purple
ILightPurple='\033[0;177m'      # Light Purple
IPink='\033[0;200m'             # Pink
IGrey='\033[0;246m'             # Grey

# Bold High Intensity
BIBlack='\033[1;90m'            # Black
BIWhite='\033[1;97m'            # White
BIRed='\033[1;91m'              # Red
BIOrange='\033[1;214m'          # Orange
BIYellow='\033[1;93m'           # Yellow
BIGreen='\033[1;92m'            # Green
BICyan='\033[1;96m'             # Cyan
BIBlue='\033[1;94m'             # Blue
BIPurple='\033[1;95m'           # Purple
BILightPurple='\033[1;177m'     # Light Purple
BIPink='\033[1;200m'            # Pink
BIGrey='\033[1;246m'            # Grey

# High Intensity backgrounds
On_IBlack='\033[0;100m'             # Black
On_IWhite='\033[0;107m'             # White
On_IRed='\033[0;101m'               # Red
On_IOrange='\033[0;214m'            # Orange
On_IYellow='\033[0;103m'            # Yellow
On_IGreen='\033[0;102m'             # Green
On_ICyan='\033[0;106m'              # Cyan
On_IBlue='\033[0;104m'              # Blue
On_IPurple='\033[0;105m'            # Purple
On_ILightPurple='\033[0;177m'       # Light Purple
On_IPink='\033[0;200m'              # Pink
On_IGrey='\033[0;246m'              # Grey
