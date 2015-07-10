# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export GOROOT=/usr/local/go
export GOPATH=$HOME/dev/golang

# Ensure user-installed binaries take precedence
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/php5/bin:$GOROOT/bin:$GOPATH/bin:/usr/bin:/bin:/usr/sbin:/sbin::$PATH

# Setup JAVA_HOME on MAC
if [ -e "/usr/libexec/java_home" ] 
then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# My Own Android Developer Tools
export ANDROID_HOME=~/adt/sdk
export PATH=:~/adt/sdk/tools:~/adt/sdk/platform-tools:~/adt/sdk/build-tools/18.1.1:$PATH

# Short cut alias
alias vi=vim
alias tmux="TERM=screen-256color-bce tmux"

# Homestead virturl box via vagrant
alias vm='ssh vagrant@127.0.0.1 -p 2222'

# AWS command line tools
complete -C '/usr/local/bin/aws_completer' aws

# Set ls color mode
platform='unknown'
unamestr=`uname -s`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='freebsd'
fi

if [[ $platform == 'linux' ]]; then
    alias ls='ls --color=auto'
elif [[ $platform == 'freebsd' ]]; then
    export CLICOLOR=1
fi

export LANG=en_US.UTF-8

set meta-flag on
set input-meta on
set output-meta on
set convert-meta off

if [ -f ~/.agent.env ] ; then
    . ~/.agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning new agent… "
        eval `ssh-agent | tee ~/.agent.env`
        ssh-add
    fi 
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.agent.env`
    ssh-add
fi

# Load .bashrc if it exists
[[ -s ~/.bashrc ]] && source ~/.bashrc
