autoload -U colors && colors
autoload -U promptinit && promptinit

function parse_git_branch () {
    if git config --get zsh.hide-prompt > /dev/null; then
        return;
    fi;
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [[ "$branch" != "" ]]; then
        git_status=$(git status -s -b)
        unstaged_changes=($(echo $git_status | tail -n+2 | egrep '^.[DMAU]' | wc -l))
        staged_changes=($(echo $git_status | tail -n+2 | egrep '^[DMAU].' | wc -l))
        echo $git_status | head -n 1 | egrep -q '\[.*ahead.*\]$'
        ahead=$?
        echo $git_status | head -n 1 | egrep -q '\[.*behind.*\]$'
        behind=$?
        remote_status=''
        if [[ $ahead == 0 && $behind == 0 ]]; then
            remote_status='(≷)'
        else
            if [[ $ahead == 0 ]]; then
                remote_status='(>)'
            fi
            if [[ $behind == 0 ]]; then
                remote_status='(<)'
            fi
        fi
        if [[ $unstaged_changes != 0 ]]; then
            if [[ $staged_changes != 0 ]]; then
                echo "on %{$fg_bold[yellow]%}$branch%{$reset_color%} $remote_status"
            else
                echo "on %{$fg[red]%}$branch%{$reset_color%} $remote_status"
            fi
        else
            if [[ $staged_changes != 0 ]]; then
                echo "on %{$fg[green]%}$branch%{$reset_color%} $remote_status"
            else
                echo "on $branch $remote_status"
            fi
        fi
    fi
}

function parse_svn_branch () {
    url=$(svn info --xml | grep '^<url>')
    branch=${${url%</url>}##<url>*/}
    if [[ "$branch" != "" ]]; then
        file_changes=($(svn st --ignore-externals | grep '^[DMAC]' | wc -l))
        property_changes=($(svn st --ignore-externals | grep '^.[DMAC]' | wc -l))
        changes=$(($file_changes + $property_changes))
        if [[ $changes != 0 ]]; then
            echo "on %{$fg[red]%}$branch%{$reset_color%}"
        else
            echo "on $branch"
        fi
    fi
}

function parse_branch () {
    if [[ "$PROMPT_NO_BRANCH" != "" ]]; then
        return
    fi
    if git rev-parse --is-inside-work-tree > /dev/null 2> /dev/null; then
        parse_git=$(git rev-parse --is-inside-work-tree)
    fi
    if test "$parse_git" != "false" && git branch > /dev/null 2> /dev/null; then
        parse_git_branch
    elif svn info > /dev/null 2> /dev/null; then
        parse_svn_branch
    fi
}

function parse_venv () {
    VENV=$(basename "$VIRTUAL_ENV")
    if [[ "$VENV" != "" ]]; then
        echo "($VENV) "
    fi
}

current_time='%{$fg[blue]%}[%*]%{$reset_color%}'
current_user='%{$fg[green]%}%n@%m%{$reset_color%}'
current_path='%{$fg[red]%}${PWD/#$HOME/~}%{$reset_color%}'
current_branch='$(parse_branch)'
current_venv='$(parse_venv)'

setopt prompt_subst
export PROMPT="$current_time $current_user $current_path $current_venv$current_branch$prompt_newline%# "
precmd () {print -Pn "\e]0;%20<..<%/\a"}
