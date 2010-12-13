# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/sixarm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Load aliases from a file if it exists
if [ -f ~/.zsh.aliases ]; then
    . ~/.zsh.aliases
fi
