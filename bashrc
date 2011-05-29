#load configuration from these other files

. ~/.dotfiles/bash/env/init
. ~/.dotfiles/bash/config
. ~/.dotfiles/bash/aliases

# load the local rc file
test -f ~/.dotfiles/bash/local/`hostname -f` && . ~/.dotfiles/bash/local/`hostname -f`
