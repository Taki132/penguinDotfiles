# ~/.zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Greeting
echo "welcome back $(whoami)!" 

# Prompt
PS1='%~ # '

# Auto startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

# Aliases
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias cl='clear'

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
