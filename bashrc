# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

parse_git_branch() {
  branch=$(git branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    echo "[$branch]"
  fi
}
short_pwd() {
  local path=$PWD
  local count=$(ls -A | wc -l)

  # Split into array
  IFS=/ read -ra parts <<<"$path"
  local n=${#parts[@]}

  if (( n > 3 )); then
    echo -e "\033[01;34m…/\033[01;31m${parts[n-3]}\033[01;34m/\
\033[01;33m${parts[n-2]}\033[01;34m/\
\033[01;32m${parts[n-1]}\033[01;34m {$count}"
  else
    # Just show normal path if shallow
    echo -e "\033[01;34m$path {$count}"
  fi
}



if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\$(short_pwd) \[\033[01;33m\]\$(parse_git_branch)\[\033[00m\]\$ "

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# convert wave to mp3
# alias wav2mp3='function _wav2mp3(){ \
#   f="${1%.wav}"; \
#   ffmpeg -i "$f.wav" -codec:a libmp3lame -qscale:a 2 "$f.mp3"; \
# }; _wav2mp3'
wav2mp3() {
  f="${1%.wav}"
  ffmpeg -i "$f.wav" -codec:a libmp3lame -qscale:a 2 "$f.mp3"
}

# Update git in one command
git-up() {
        git commit -am "$1"
        git push
}
# fix local repo discard local changes
alias git-fix='git fetch && reset --hard'
# update git in one command
alias git-update='git-up'


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# list delux
alias ls='lsd --group-dirs first'


# Directory aliases
alias tree='find . | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'
alias goElec='cd /media/sherwood/Data/Documents/src/Electronics-Game/'
alias goSource='cd /media/sherwood/Data/Documents/src/'
alias goYoutube='cd /media/sherwood/Data/apps/youtube-dl'
alias goCPP='cd /home/sherwood/Documents/src/cplusplus/'
alias goECS='cd /home/sherwood/Documents/src/cplusplus/Entity_Component_System'

# Run program
alias goPass='cd /media/sherwood/Data/Documents/Get-P-Word/ && python3 /media/sherwood/Data/Documents/Get-P-Word/openFile4.py'

countFiles() {
    exts=()
    for ext in "$@"; do
        exts+=(-o -name "*$ext")
    done
    # Drop the first "-o" (bash slice syntax)
    exts=("${exts[@]:1}")

    find . -maxdepth 1 -type f \( "${exts[@]}" \) | wc -l
}


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
alias edge='firejail --noprofile --net=none /usr/bin/microsoft-edge file:///media/sherwood/Data/Thru_The_Bible/calendar.pdf'

# Start winows with only C drive
alias gogoWindows="sudo qemu-system-x86_64 -enable-kvm -m 16G -cpu host -smp 6 -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS_4M.fd -drive file=/dev/nvme0n1,format=raw,if=ide -boot c"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
