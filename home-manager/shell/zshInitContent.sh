# ZSH configuration file

push() {
    REMOTES=$@

    # If no remotes were passed in, push to all remotes.
    if [[ -z "$REMOTES" ]]; then
        REM=$(git remote)

        # Break the remotes into an array
        REMOTES=$(echo $REM | tr " " "\n")
    fi

    # Iterate through the array, pushing to each remote
    for R in $REMOTES; do
        tput setaf 212
        echo "Pushing to $R..."
        tput sgr0
        git push $R
    done
}

save() {
    git add -u
    git commit -m'auto save'
    push $@
    while [ $? -eq 128 ]; do
        sleep 0.5
        func_GitPush $@
    done
}

mdd() {
    git add -u
    git commit -m"MDD: $1-$(date '+%s'),"
    git tag -ma "$1-$(date '+%s')"
    git push --follow-tags
    while [ $? -eq 128 ]; do
        sleep 0.5
        git push --follow-tags
    done
}

tard() {
    if [ -f "$1" ]; then
        tar -xf "$1" && rm -i "$1"
    else
        echo "Error: File '$1' does not exist."
    fi
}
_tard() {
    _files -g '*.tar(.N)|*.tar.gz(.N)|*.tgz(.N)|*.tar.bz2(.N)|*.tbz(.N)|*.tar.xz(.N)|*.txz(.N)'
}
compdef _tard tard

mkt() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}
_mkt() {
    _files -/d
}
compdef _mkt mkt


# bindkey #
### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

### ctrl+delete
bindkey "\e[3;5~" kill-word
# urxvt
bindkey "\e[3^" kill-word

### ctrl+backspace
bindkey '^H' backward-kill-word

### ctrl+shift+delete
bindkey "\e[3;6~" kill-line
# urxvt
bindkey "\e[3@" kill-line

### run code when selected completion
bindkey -M menuselect '^M' .accept-line

# alias
alias mktmp="source mktmp_pkg $@"

#JWS
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGPORT="5432"
