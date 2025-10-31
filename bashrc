echo "Running .bashrc"
######################################################################
#  
#   ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄     ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄  
#  █       █  █ █  █       █   ▄  █ █ █ ▄ █ █       █       █      █ 
#  █  ▄▄▄▄▄█  █▄█  █    ▄▄▄█  █ █ █ █ ██ ██ █   ▄   █   ▄   █  ▄    █
#  █ █▄▄▄▄▄█       █   █▄▄▄█   █▄▄█▄█       █  █ █  █  █ █  █ █ █   █
#  █▄▄▄▄▄  █   ▄   █    ▄▄▄█    ▄▄  █       █  █▄█  █  █▄█  █ █▄█   █
#   ▄▄▄▄▄█ █  █ █  █   █▄▄▄█   █  █ █   ▄   █       █       █       █
#  █▄▄▄▄▄▄▄█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄█  █▄█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄█                                                                       
# 
#   ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ 
#  █  ▄    █       █       █  █ █  █   ▄  █ █       █
#  █ █▄█   █   ▄   █  ▄▄▄▄▄█  █▄█  █  █ █ █ █       █
#  █       █  █▄█  █ █▄▄▄▄▄█       █   █▄▄█▄█     ▄▄█
#  █  ▄   ██       █▄▄▄▄▄  █   ▄   █    ▄▄  █    █   
#  █ █▄█   █   ▄   █▄▄▄▄▄█ █  █ █  █   █  █ █    █▄▄ 
#  █▄▄▄▄▄▄▄█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄█ █▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█
#  
######################################################################


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# Makre sure we don't run unnecessary configurations
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
# update the values of LINES and COLUMNS.  (FOR DYNAMIC TERMINAL RESIZING)
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

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] [$(parse_git_branch)]\$ '
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[01;33m\]$(parse_git_branch)\[\033[00m\]\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[01;33m\]$(parse_git_branch)\[\033[00m\]\$ '
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

###########################
### ALIAS SECTION

# alias functions
git-up() {
	git commit -am "$1"
	git push
}
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Used to fix Personal Project Python Problems
alias python='/usr/local/bin/python3.9'
alias python3='/usr/local/bin/python3.9'
alias py='/usr/local/bin/python3.9'

alias sdev-os='cd /home/sherwood/Documents/school/Bachelors\ Degree/School-SDEV-385-81'
alias sdev-linux='cd /home/sherwood/Documents/school/Bachelors\ Degree/School-SDEV-415-81'
alias master='cd /home/sherwood/Documents/school/Masters-Degree'
alias MB='cd /home/sherwood/Documents/school/Masters-Degree/School-MBA-506-81'
alias MGMT='cd /home/sherwood/Documents/school/Masters-Degree/School-MGMT-537-81'
alias goAda='cd /home/sherwood/Documents/ada'
alias goLaTeX='cd /home/sherwood/Documents/LaTeX/'
alias goElec='cd /home/sherwood/Documents/electronic-game/'

alias lotgd='cd /home/sherwood/Documents/cplusplus/LOTGD-Clone'
alias goCppRefresher='cd /home/sherwood/Documents/cplusplus/antiRTFM/2025refresher'
alias goModernCPP='cd /home/sherwood/Documents/cplusplus/modernCPP'
alias goPlant='cd /home/sherwood/Documents/cplusplus/PlantSimulator'

alias git-fix='git fetch --all && git reset --hard origin/master'
alias git-update='git-up'
alias gp='git pull'
# alias compile='function _compile() { local name="${1%.*}"; g++ -std=c++11 "$1" -o "$name"; }; _compile'
alias compile='function _compile() { local name="${1%.*}"; g++ -std=c++11 -o "$name" "${@:1}"; }; _compile'

alias vim='/usr/local/bin/vim'
alias restartKDE='sudo systemctl restart sddm'


# Compiling languages and assistance
alias AlrSetEnv='alr settings --global --set editor.cmd "code workspace.code-workspace"'
alias AlrInitProj='alr init --bin "$1"'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# convert wave to mp3
# alias wav2mp3='function _wav2mp3(){ \
#   f="${1%.wav}"; \
#   ffmpeg -i "$f.wav" -codec:a libmp3lame -qscale:a 2 "$f.mp3"; \
# }; _wav2mp3'
wav2mp3() {
  f="${1%.wav}"
  ffmpeg -i "$f.wav" -codec:a libmp3lame -qscale:a 2 "$f.mp3"
}

findWord() {
	local myArgs="-R -n -i --binary-files=without-match --exclude-dir=.git --color=always -E"
	local path="." pattern=""

	while [ $# -gt 0 ]; do
		case "$1" in
			-up) myArgs="$myArgs -B $2"; shift 2 ;;
			-down) myArgs="$myArgs -A $2"; shift 2 ;;
			-i) myArgs="$myArgs -i"; shift 2 ;;
			*) break ;;
		esac
	done

	# Pattern (required) and optional path
	pattern="${1:-}"; shift || true
	[[ -z "$pattern" ]] && { echo "Usage: findWord [-up N] [-down M] [-i] -- PATTERN [PATH]"; return 1; }
	[ $# -gt 0 ] & path="$1"

	# Run grep 
	echo "grep $myArgs -- $pattern $path"
	local commands="$myArgs $pattern $path"
	grep $commands
}

countFiles() {
    exts=()
    for ext in "$@"; do
        exts+=(-o -name "*$ext")
    done
    # Drop the first "-o" (bash slice syntax)
    exts=("${exts[@]:1}")

    find . -maxdepth 1 -type f \( "${exts[@]}" \) | wc -l
}

# Combine all .cpp and .hpp into a single .txt file.
combineFiles() {
  local out="$1"
  if [[ -z "$out" ]]; then
    echo "Usage: bundle_cpp <output>.txt"
    return 2
  fi
  [[ "$out" != *.txt ]] && out="${out}.txt"

  find . -type f \( -name '*.cpp' -o -name '*.hpp' \) \
    ! -path './.git/*' ! -path './build/*' -print0 \
  | sort -z \
  | while IFS= read -r -d '' f; do
      printf "===== FILE: %s =====\n" "$f"
      cat "$f"
      printf "\n\n"
    done > "$out"

  echo "Wrote $out"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[[ -f ~/.bash_profile ]] && source ~/.bash_profile

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

PATH="/opt/gnatstudio/bin:$PATH"; export PATH
# Add personal directory to th path
export PATH=$PATH:/home/sherwood/bin
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
