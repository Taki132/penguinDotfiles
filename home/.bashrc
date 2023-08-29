#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\W \$ '

# Auto startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias scrrec='ffmpeg -framerate 60 -f x11grab -i $DISPLAY -pix_fmt yuv420p $HOME/Videos/$(date +"%Y-%m-%d-%T")-rec.mp4'
