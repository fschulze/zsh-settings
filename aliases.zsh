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
alias m="mate"
alias gs="git svn"
alias jslint="java org.mozilla.javascript.tools.shell.Main /Users/fschulze/Development/jslint.js"
alias srcgrep="grep --exclude \"*.pyc\" --exclude \".git\" --exclude \"*.svn-base\" --exclude \"all-wcprops\" --exclude \"entries\" --exclude \"*.tmp\" -r"
alias srcdiff="diff -ru -x .svn -x .git -x *.py[co] -x *.egg-info"

function pmate () {
    setopt local_options no_nomatch
    mate *.cfg CHANGES* bin/ cfgs/ docs/ etc/ src/ templates/ production/ $*
}
alias pm="pmate"

function dmate () {
    setopt local_options no_nomatch
    if /Users/fschulze/bin/develop info -a -p > /dev/null; then
        sources=$(/Users/fschulze/bin/develop info -a -p)
    fi
    sources=${${${(f)sources}#$(pwd)/}/%/\/}
    echo mate *.cfg CHANGES* bin/ cfgs/ docs/ etc/ ${=sources} templates/ production/ $*
    mate *.cfg CHANGES* bin/ cfgs/ docs/ etc/ ${=sources} templates/ production/ $*
}

source ~/.zsh/jump.zsh
alias j="jump"

function eggpath() {
    local name=$1;
    shift;
    local files=$*;
    if [ -z $files ]; then
        local files="$files ./bin/instance* ./bin/client*";
    fi
    setopt local_options null_glob;
    grep -o -E "/.*$name.*.egg" ${~files} | sort -u;
}

function pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}
