#	---------------------------------------------------------------------------------------------
#
#	  ██████╗ ██████╗ ██╗███╗   ███╗███╗   ███╗███████╗████████╗ █████╗ ██████╗
#	 ██╔════╝ ██╔══██╗██║████╗ ████║████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
#	 ██║  ███╗██████╔╝██║██╔████╔██║██╔████╔██║███████╗   ██║   ███████║██████╔╝
#	 ██║   ██║██╔══██╗██║██║╚██╔╝██║██║╚██╔╝██║╚════██║   ██║   ██╔══██║██╔══██╗
#	 ╚██████╔╝██║  ██║██║██║ ╚═╝ ██║██║ ╚═╝ ██║███████║   ██║   ██║  ██║██║  ██║
#	  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
#
#	---------------------------------------------------------------------------------------------
#
#	 .bash_profile
#	    This file holds all my BASH configurations
#
#	 Source:
#	   [Grimmstar's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#	 Authors:
#	   Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#	---------------------------------------------------------------------------------------------
#
#	Sections:
#		1.   Environment Configuration
#
#	---------------------------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Case-insensitive globbing (used in pathname expansion)
#   ------------------------------------------------------------
shopt -s nocaseglob

#   Append to the Bash history file, rather than overwriting it
#   ------------------------------------------------------------
shopt -s histappend

#   Autocorrect typos in path names when using `cd`
#   ------------------------------------------------------------
shopt -s cdspell

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
