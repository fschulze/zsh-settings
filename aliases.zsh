#/bin/zsh
alias ls="gls --color=auto"
alias l="gls --color -lh"
alias ll="gls --color -lha"
alias ..="cd .."
alias ...="cd ..; cd .."
alias vi="vim"
alias sha1="openssl sha1"
alias d="develop"
alias g="git"
alias m="mate"
alias gs="git svn"
alias s="subl"
alias annex="git annex"
alias jslint="java org.mozilla.javascript.tools.shell.Main /Users/fschulze/Development/jslint.js"
alias srcgrep="grep --exclude \"*.pyc\" --exclude \".git\" --exclude \"*.svn-base\" --exclude \"all-wcprops\" --exclude \"entries\" --exclude \"*.tmp\" -r"
alias srcdiff="diff -ru -x .svn -x .git -x \*.py\[co\] -x \*.egg-info"
# alias failed_tests="pbpaste | grep 'test.*(' | cut -d\( -f1 | xargs | tr ' ' '\|'"
# alias failed_tests="pbpaste | egrep '^  (test.*\(|/.*\.txt)' | cut -d\( -f1 | sed 's,.*/,,' | xargs | tr ' ' '\|' | xargs -J% bin/alltests -v -v -v -t '%'"
# alias failed_tests="pbpaste | grep 'test.*(' | awk '{print \$1 \".*\" \$2}' | xargs | tr ' ' '\|'"
alias failed_tests="pbpaste | egrep '^ +(test.*\(|/.*\.txt)' | cut -d\( -f1 | sed 's,.*/,,' | xargs | tr ' ' '\|'"

h() {
    if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi;
}

function hl () {
    hl="-------- $1 ---------------------------";
    hl="$hl------------------------------------";
    echo $hl[0,72];
}

function pmate () {
    setopt local_options no_nomatch
    mate *.txt *.rst *.cfg bin/ cfgs/ docs/ etc/ src/ templates/ production/ $*
}

function psubl () {
    if test ! -e default.sublime-project && dialog --defaultno --title "Create Project" --backtitle "There is no Sublime Text Project File in the current directory" --yesno "Create Sublime Text Project File?" 7 60; then
        cat > default.sublime-project <<"_END_"
{
    "folders": [
        {
            "path": ".",
            "file_exclude_patterns": [
                "*.sublime-workspace", ".installed.cfg", ".mr.developer.cfg"
            ],
            "folder_exclude_patterns": [
                "*.egg-info", "coverage", "develop-eggs", "eggs", "parts",
                "temp", "tmp", "var"
            ]
        }
    ]
}
_END_
    fi
    if test -e default.sublime-project; then
        subl --project default.sublime-project
    fi
}

alias pm="psubl"

function dmate () {
    setopt local_options no_nomatch
    if /Users/fschulze/bin/develop info -a -p > /dev/null; then
        sources=$(/Users/fschulze/bin/develop info -a -p)
    fi
    sources=${${${(f)sources}#$(pwd)/}/%/\/}
    echo mate *.cfg CHANGES* bin/ cfgs/ docs/ etc/ ${=sources} templates/ production/ $*
    mate *.cfg CHANGES* bin/ cfgs/ docs/ etc/ ${=sources} templates/ production/ $*
}

source $HOME/.zsh/jump.zsh
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

function cherries {
    for arg in $*; do
        for ticket in $( echo $arg | tr '-' ' ' ); do
            for branch in $( git branch -r | grep $ticket ); do
                hl $branch
                git cherry -v master $branch
            done
        done
    done
}

alias ql="qlmanage -p"
