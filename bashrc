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
