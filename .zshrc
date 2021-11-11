if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/root/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function cyclic(){eval "python3 -c 'from pwn import *;print(cyclic($1))'"}
alias python=python3
alias py64="python -i -c 'from pwn import *;context.arch=\"amd64\"'"
alias clock='tty-clock -sct -f "%a, %d %b %Y %T %z"'