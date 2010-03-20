# this makes the "delete" key work rather than
# just entering a ~
bindkey '\e[3~' delete-char

# these allow you to use ctrl+left/right arrow keys
# to jump the cursor over words
bindkey '\e[5C' forward-word
bindkey '\e[5D' backward-word

# these allow you to start typing a command and
# use the up/down arrow to auto complete from
# commands in your history
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # success, go to end of line
      zle .end-of-line
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\e[B' history-beginning-search-forward-end
bindkey '\e[A' history-beginning-search-backward-end

# expand wildcards on the command line
bindkey '^G' expand-word

# allow to select more than one match in menues with ctrl-space
bindkey -M menuselect '^@' accept-and-menu-complete
# select and find new matches with ctrl-enter
bindkey -M menuselect "\t" accept-and-infer-next-history
