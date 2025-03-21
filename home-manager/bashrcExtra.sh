#export PS1='$(tput setaf 6)$(($(ps|wc -l) - 4))$(tput setaf 211)!$(tput setaf 6)\W$(tput setaf 211)|$(tput setaf 6)$(git branch --show-current 2>/dev/null) $(tput setaf 33)(^･ω･^)$(tput sgr0)$ '

func_GitPush() {
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

func_save() {
    git add -u
    git commit -m'auto save'
    func_GitPush $@
    while [ $? -eq 128 ]; do
        sleep 0.5
        func_GitPush $@
    done
}

func_pushtag() {
    git add -u
    git commit -m"MDD: $1-$(date '+%s'),"
    git tag -ma "$1-$(date '+%s')"
    git push --follow-tags
    while [ $? -eq 128 ]; do
        sleep 0.5
        git push --follow-tags
    done
}

alias save="func_save"
alias push="func_GitPush"
alias mdd="func_pushtag"

# Startup
kitten icat --align left /home/baptiste/nix/assets/catboy_small.jpg

eval $(thefuck --alias f)
