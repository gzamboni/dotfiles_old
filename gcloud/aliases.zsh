#!/bin/zsh
# Path: gcloud/aliases.zsh

export CLOUDSDK_PYTHON=/Users/gzamboni/.asdf/installs/python/3.11.3/bin/python

alias gcloud='gcloud --quiet'
alias gcp='gcloud'
alias gcp-login='gcloud auth login'
alias gcp-logout='gcloud auth revoke'
alias gcp-whoami='gcloud auth list'
alias gcp-whoami-active='gcloud auth list --filter=status:ACTIVE'
alias gcp-whoami-active-account='gcloud auth list --filter=status:ACTIVE --format="value(account)"'
alias gcpp='gcloud projects'
alias gcppl='gcloud projects list'
alias gcpps='gcloud projects set'
alias gcpa='gcloud auth'
alias gcpal='gcloud auth list'
alias gcpac='gcloud auth configure-docker'
alias gcpa-activate='gcloud auth activate-service-account'
