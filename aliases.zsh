#/bin/zsh
alias ls="ls -w"
alias l="ls -lhw"
alias ll="ls -lhaw"
alias ..="cd .."
alias ...="cd ..; cd .."
alias vi="vim"
alias sha1="openssl sha1"
alias d="develop"
alias g="git"
alias gs="git svn"
alias jslint="java org.mozilla.javascript.tools.shell.Main /Users/fschulze/Development/jslint.js"
alias srcgrep="grep --exclude \"*.pyc\" --exclude \"*.svn-base\" --exclude \"all-wcprops\" --exclude \"entries\" --exclude \"*.tmp\" -r"
alias srcdiff="diff -ru -x .svn -x .git -x *.py[co] -x *.egg-info"

function pmate () {
    setopt local_options no_nomatch
    mate *.cfg CHANGES* bin/ cfgs/ etc/ src/ templates/ production/ $*
}

source ~/.zsh/jump.zsh
alias j="jump"

function eggpath() {
    local name=$1;
    shift;
    local files=$*;
    if [ -z $files ]; then
        if [ -e ./bin/instance* ]; then
            local files="$files ./bin/instance*";
        fi
        if [ -e ./bin/client* ]; then
            local files="$files ./bin/client*";
        fi
    fi
    grep -o -E "/.*$name.*.egg" $files | sort -u;
}
