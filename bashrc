# alias functions

# Update git in one command
git-up() {
        git commit -am "$1"
        git push
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias python='/usr/local/bin/python3.9'
alias python3='/usr/local/bin/python3.9'
alias py='/usr/local/bin/python3.9'

alias math170='cd /home/sherwood/Documents/school/School-MATH-170-45'
alias math270='cd /home/sherwood/Documents/school/School-MATH-270-45'
alias scie180='cd /home/sherwood/Documents/school/School-SCIE-180-45'
# fix local repo discard local changes
alias git-fix='git fetch && reset --hard'
# update git in one command
alias git-update='git-up'

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

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\$(dirname \$(dirname \$(dirname \w)) | sed -e 's;\(/.\)[^/]*;\1;g')/\[\033[01;31m\]\$(basename \$(dirname \$(dirname \w)))\[\033[01;34m\]/\[\033[01;33m\]\$(basename \$(dirname \w))\[\033[01;34m\]/\[\033[01;32m\]\$(basename \w)\[\033[01;34m\] {\$(ls -A | wc -l)} \[\033[00m\]\$ "
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

