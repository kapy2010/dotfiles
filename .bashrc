export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# read system-wide bashrc if it exists
bash_prefix=$(dirname $(dirname $(which bash)))
if [ -f "$bash_prefix/etc/bashrc" ]; then
    . "$bash_prefix/etc/bashrc"
fi
unset bash_prefix

#
# general stuff
#
# update window size after every command
shopt -s checkwinsize

#
# better bash history
#
# don't put duplicate lines or lines starting with space
export HISTCONTROL="erasedups:ignoreboth"

# append to history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=200000
export HISTFILESIZE=300000

# enable incremental history search with up/down arrows (also Readline goodness)
# http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

#
# smarter tab completion (readline bindings)
#
# perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

#
# colored less
#
if [ -f "/usr/local/bin/src-hilite-lesspipe.sh" ]; then
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
fi

#
# path
#
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/python/libexec/bin:$PATH

#
# java
#
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Djava.awt.headless=true"
if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    alias java7="export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)"
    alias java8="export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)"
fi

#
# mac-specific stuff
#
if [ "$(uname -s)" = "Darwin" ]; then
    # cli colors
    export CLICOLORS=yes
    export LSCOLORS='ExGxFxdaCxDADAhbadecad'
fi

#
# other includes
#
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
    # this will also load ~/.bash_completion if it exists
    . /usr/local/etc/bash_completion
fi
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi
if [ -f /usr/local/Library/Contributions/brew_bash_completion.sh ]; then
    . /usr/local/Library/Contributions/brew_bash_completion.sh
fi

# set proxy
if [ -f ~/.setproxy ]; then
    . ~/.setproxy
fi

# autojump
if [ -f /usr/local/etc/autojump.sh ]; then
    . /usr/local/etc/autojump.sh
fi

#
# colored prompt
#
export PS1='\[\e[1;34m\]\w\[\e[1;30m\]$(__git_ps1)\[\e[0m\]\$ '

# setup virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# epab-solr
export EPAB_SOLR_JETTY=/Users/kapil/repos/bring/kp-epab-solr/local-server
export EPAB_SOLR_HOME=/Users/kapil/repos/bring/kp-epab-solr/local-server/./solr-home
export EPAB_SQLITE_DB=/Users/kapil/repos/bring/kp-epab-solr/dbseeds/seeds.sqlite3
export EPAB_SQLITE_DB_TEST=/Users/kapil/repos/bring/kp-epab-solr/dbseeds/seeds_test.sqlite3

# for rbenv
PATH=$HOME/.rbenv/bin:$PATH
if [[ $(command -v ruby) ]]; then
  PATH=$(ruby -e 'puts ENV["PATH"].split(":").uniq.join(":")')
fi
[[ $(command -v rbenv) ]] && eval "$(rbenv init -)"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# b-scripts
export BRING_DIR="$HOME/repos/bring"
if [[ -d "$BRING_DIR" && -x $BRING_DIR/b-scripts/bin/b ]]; then
    eval "$($BRING_DIR/b-scripts/bin/b init -)"
fi
export POSTEN_SLACK_USERNAME=kapy

# groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

#
# local overrides (.bashrc.local isn't in the dotfiles repo)
#

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# postresql
export PATH="/Applications/Postgres.app/Contents/Versions/9.6/bin:$PATH"


alias tunnel_postgres_test='ssh -L 5555:pg-a.test.bd.bring.no:5432 bring@mybring1test.bd.bring.no'
alias tunnel_postgres_qa_a='ssh -L 5555:pg-a.qa.bd.bring.no:5432 bring@mybring1qa.bd.bring.no'
alias tunnel_postgres_qa_b='ssh -L 5555:pg-b.qa.bd.bring.no:5432 bring@mybring1qa.bd.bring.no'
alias tunnel_postgres_prod_a='ssh -L 5555:pg-a.bd.bring.no:5432 bring@mybring1prod.bd.bring.no'
alias tunnel_postgres_prod_b='ssh -L 5555:pg-b.bd.bring.no:5432 bring@mybring1prod.bd.bring.no'
alias postenidqatunnel='ssh -L 5435:pg-b.qa.bd.bring.no:5432 mybring1qa'
alias postenidprodtunnel='ssh -L 5439:pg-b.bd.bring.no:5432 mybring1prod'
alias postenidtesttunnel='ssh -L 5429:pg-a.test.bd.bring.no:5432 mybring1test'

# for viewing markdown files from terminal
rmd () {
  pandoc $1 | lynx -stdin
}

