# ~/.zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

setopt prompt_subst

# Greeting
echo "welcome back $USER!"

case $TERM in
	linux) PROMPT=' %1~%F{%(?.4.1)} %(!.|./) %f';;
	*)  PROMPT=$'%{\e[?25h\e[4 q%}%{$(topdir)%} > %f'
esac

topdir() {
	## display dir in top-right
	[ "$PWD" = "$HOME" ] && v='~' || v=${PWD##*/}
	op=${OLDPWD##*/}

	# save cursor pos, move cursor to the top-right
	# then delete the previous contents
	# then print the new dir and restore cursor pos
	printf '%b%b%b' \
		"\033[s\033[0;9999H" \
		"\033[${#op}D\033[K" \
		"\033[999C\033[${#v}D$v\033[u"
}

# Auto startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

# Aliases
alias pls='sudo'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias cl='clear'

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# cute sudo
export SUDO_PROMPT="give me %u's pass pls: "

# not found
command_not_found_handler() {
	printf '%s%s? i dont know what is it\n' "$acc" "$0" >&2
    return 127
}
	
