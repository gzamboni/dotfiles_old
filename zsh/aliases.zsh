#!/bin/sh
alias reload!='exec "$SHELL" -l'
alias vim=nvim
alias ls="exa --icons --group-directories-first"

function gptmodels() {
	curl -s https://api.openai.com/v1/models -H "Authorization: Bearer $OPENAI_API_KEY" | jq '.data[] | select(.id | contains("'$1'")) | .id'
}
