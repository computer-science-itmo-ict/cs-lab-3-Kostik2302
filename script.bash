#bin!/bash
export LANG=en_US.UTF-8
#find ./dir -print | sed 's![^/]*/!|   !g' 
dirs_count=0
files_count=0
ne_tree() {
    local path=$1
    local main_path=$2
    local prefix=$3
    local adapter=$4
    local child_rung=$5
    printf "%s%s%s\n" "$prefix" "$adapter" "${path##"$main_path"}"
    if  [ -d "$path" ]; then
        ((dirs_count++))

        local all_subfiles=("$path"/*)
        local amount=${#all_subfiles[@]}
        local i=0
        for (( ; i < amount; i++)); do
            local begin
            local middle
            if [[ i -eq $((amount - 1)) ]]; then
                begin="└── "
                middle="    "
            else
                begin="├── "
                middle="│    "
            fi

            ne_tree "${all_subfiles[i]}" "$path/" "$prefix$child_rung" "$begin" "$middle"
        done
    else
        ((files_count++))
    fi
}

root=${1%%"/"}
ne_tree "$root"

printf "\n%s %s, %s %s\n" "$dirs_count" "directories" "$files_count" "files"