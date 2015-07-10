# gitprompt configuration

# Set config variables first
# GIT_PROMPT_ONLY_IN_REPO=1

# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

# GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

# as last entry source the gitprompt script
# GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
# GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
GIT_PROMPT_THEME=Solarized

# put this in your .bash_profile
#if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${HOSTNAME}\007"; ':"$PROMPT_COMMAND";
#fi
 
# Piece-by-Piece Explanation:
# the if condition makes sure we only screw with $PROMPT_COMMAND if we're in an iTerm environment
# iTerm happens to give each session a unique $ITERM_SESSION_ID we can use, $ITERM_PROFILE is an option too
# the $PROMPT_COMMAND environment variable is executed every time a command is run
# see: ss64.com/bash/syntax-prompt.html
# we want to update the iTerm tab title to reflect the current directory (not full path, which is too long)
# echo -ne "\033;foo\007" sets the current tab title to "foo"
# see: stackoverflow.com/questions/8823103/how-does-this-script-for-naming-iterm-tabs-work
# the two flags, -n = no trailing newline & -e = interpret backslashed characters, e.g. \033 is ESC, \007 is BEL
# see: ss64.com/bash/echo.html for echo documentation
# we set the title to ${PWD##*/} which is just the current dir, not full path
# see: stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-bash-script
# then we append the rest of $PROMPT_COMMAND so as not to remove what was already there
# voilà!

gitprompt="$HOME/.bash-git-prompt/gitprompt.sh"
[[ -s $gitprompt ]] && source $gitprompt

rvmscript="$HOME/.rvm/scripts/rvm"
[[ -s $rvmscript ]] && source $rvmscript 

boot2docker="/usr/local/bin/boot2docker"
#[[ -s $boot2docker ]] && eval "$(boot2docker shellinit)"
if [[ -s $boot2docker ]]; then
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/kevin_luo/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1
fi
