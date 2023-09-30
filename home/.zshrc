# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='%~ # '

# Auto startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

# Aliases
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
alias scrrec='ffmpeg -framerate 60 -f x11grab -i $DISPLAY -preset superfast $HOME/Videos/$(date +"%Y-%m-%d-%T")-rec.mp4'
alias lgit='lazygit'
