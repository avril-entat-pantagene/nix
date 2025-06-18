echo "bash, alias not in sync..."

alias cd="z"
alias ls="lsd -A --group-dirs first"
alias tree="lsd --tree"
alias grep="grep --color -n"
alias gf="git fetch"
alias gs="git status && pre-commit"
alias lg="lazygit"
alias c="code ."
alias mktmp="source mktmp_pkg $@"


#JWS
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGPORT="5432"

eval $(thefuck --alias f)
eval "$(zoxide init bash)"