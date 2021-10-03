#	---------------------------------------------------------------------------------------------
#
#	.bashrc
#		The ~/.bashrc file determines the behavior of interactive shells.
#
#	Source:
#		[Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#	Authors:
#		Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# If it's an xterm compatible terminal, set the title to user@host: dir.
case "${TERM}" in
xterm* | rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
    ;;
*) ;;
esac

#   Case-insensitive globbing (used in pathname expansion)
#   ------------------------------------------------------------
shopt -s nocaseglob

#   Append to the Bash history file, rather than overwriting it
#   ------------------------------------------------------------
shopt -s histappend

#   Autocorrect typos in path names when using `cd`
#   ------------------------------------------------------------
shopt -s cdspell

# Ensure $LINES and $COLUMNS always get updated.
#   ------------------------------------------------------------
shopt -s checkwinsize

#   Enable some Bash 4 features when possible:
#   * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
#   * Recursive globbing, e.g. `echo **/*.txt`
#   ------------------------------------------------------------
for option in autocd globstar; do
	shopt -s "$option" 2>/dev/null
done

#   Add tab completion for many Bash commands
#   Ensure existing Homebrew v1 completions continue to work
#   ------------------------------------------------------------
if which brew &>/dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

#   Enable tab completion for `g` by marking it as an alias for `git`
#   ------------------------------------------------------------
if type _git &>/dev/null; then
	complete -o default -o nospace -F _git g
fi

#   Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
#   ------------------------------------------------------------
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Improve output of less for binary files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set a non-distracting prompt.
#PS1='\[[01;32m\]\u@\h\[[00m\]:\[[01;34m\]\w\[[00m\] \[[01;33m\]$(parse_git_branch)\[[00m\]\$ '

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Enable asdf to manage various programming runtime versions.
#   Requires: https://asdf-vm.com/#/
# source "${HOME}"/.asdf/asdf.sh

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
# export FZF_DEFAULT_OPTS="--color=dark"
# [ -f "${HOME}/.fzf.bash" ] && source "${HOME}/.fzf.bash"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi



# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

# Load all our functions
[ -f "${HOME}/.functions" ] && source "${HOME}/.functions"
[ -f "${HOME}/.functions.local" ] && source "${HOME}/.functions.local"

# Get color theme
[ -f "${HOME}/.colors" ] && source "${HOME}/.colors"
[ -f "${HOME}/.dir_colors" ] && source "${HOME}/.dir_colors/dircolors"

# Load aliases if they exist.
[ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases"
[ -f "${HOME}/.aliases.local" ] && source "${HOME}/.aliases.local"

# Load all our exports
[ -f "${HOME}/.exports" ] && source "${HOME}/.exports"
[ -f "${HOME}/.exports.local" ] && source "${HOME}/.exports.local"

# Load our paths
[ -f "${HOME}/.path" ] && source "${HOME}/.path"
[ -f "${HOME}/.path.local" ] && source "${HOME}/.path.local"

# Load our prompt
[ -f "${HOME}/.bash_prompt" ] && source "${HOME}/.bash_prompt"
[ -f "${HOME}/.bash_prompt.local" ] && source "${HOME}/.bash_prompt.local"

