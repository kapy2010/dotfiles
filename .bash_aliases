# ls
if [ "$(uname -s)" = "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias l='ls -Alh'
alias ll='ls -al'

# gnu
alias grep='ggrep --color=auto'

# misc
alias psi='echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"; ps aux|grep -i'
alias ccat='source-highlight -f esc256 -o STDOUT -i'
alias diga='dig +nocmd +multiline +noall +answer'

# maven
alias mci='mvn clean install'
alias mcis='mvn clean install -DskipTests'

# bundle
alias be='bundle exec'
alias brake='bundle exec rake'
