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

eval "$(zoxide init bash)"