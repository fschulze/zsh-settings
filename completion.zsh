fpath=($HOME/.zsh/functions $fpath)

autoload -U colors && colors
autoload -U compinit && compinit

setopt glob_complete
setopt auto_menu
setopt no_auto_list

# enable coloring
zmodload -i zsh/complist

# show completion list in groups
zstyle ':completion:*' group-name ''
# show group description
zstyle ':completion:*:descriptions' format "%{$bg_bold[green]%}%S%d%s%{$reset_color%}"

# enable case insensitive matching
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# enable menu selection
zstyle ':completion:*' menu select=1
# enable "status bar"
zstyle ':completion:*:default' select-prompt '%SMatch %M   %P%s'
# colorise files
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns
