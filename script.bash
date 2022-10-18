#!/bin/bash
export LANG=en_US.UTF-8
dir=$1
dirs_count=0
files_count=0

ne_tree() {
    local root=$1
    local branch=$2
    local subdirs=($root/*)
    local subdirs_count=${#subdirs[@]}

    for i in ${!subdirs[@]}; do
        local parent
        local child
        local name=${subdirs[i]##*/}

        if [[ $i -eq $(( $subdirs_count - 1 )) ]]; then
            parent=$'\u0020\u0020\u0020\u0020'
            child=$'\u2514\u2500\u2500\u0020'
        else
            parent=$'\u2502\u00A0\u00A0\u0020'
            child=$'\u251c\u2500\u2500\u0020'
        fi
        echo "$branch$child$name"

        if [[ -d $root/$name ]]; then 
            ((dirs_count++))
            ne_tree $root/$name "$branch$parent"
        else
            ((files_count++))
        fi
    done
}

ne_tree $dir

printf "\n%s %s, %s %s\n" "$dirs_count" "directories" "$files_count" "files"