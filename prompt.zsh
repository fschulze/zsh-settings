autoload -U colors && colors
autoload -U promptinit && promptinit

function parse_git_branch () {
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [[ "$branch" != "" ]]; then
        unstaged_changes=($(git status -s | egrep '^.[DMAU]' | wc -l))
        staged_changes=($(git status -s | egrep '^[DMAU].' | wc -l))
        if [[ $unstaged_changes != 0 ]]; then
            if [[ $staged_changes != 0 ]]; then
                echo "on %{$fg_bold[yellow]%}$branch%{$reset_color%}"
            else
                echo "on %{$fg[red]%}$branch%{$reset_color%}"
            fi
        else
            if [[ $staged_changes != 0 ]]; then
                echo "on %{$fg[green]%}$branch%{$reset_color%}"
            else
                echo "on $branch"
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

current_time='%{$fg[blue]%}[%*]%{$reset_color%}'
current_user='%{$fg[green]%}%n@%m%{$reset_color%}'
current_path='%{$fg[red]%}${PWD/#$HOME/~}%{$reset_color%}'
current_branch='$(parse_branch)'

setopt prompt_subst
export PROMPT="$current_time $current_user $current_path $current_branch$prompt_newline%# "
precmd () {print -Pn "\e]0;%20<..<%/\a"}
