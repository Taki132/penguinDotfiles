# ~/.zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Greeting
echo "welcome back $(whoami)!" 

setopt prompt_subst

# Prompt
PS1='%~
> '

# Auto startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

# Aliases
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
export SUDO_PROMPT=$'pass for %u: '

# not found
command_not_found_handler() {
	printf 'not found:%s %s\n' "$acc" "$0" >&2
    return 127
}
	
