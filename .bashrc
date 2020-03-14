#### to sync history across panes #####
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
#### to sync history across panes #####

#### increase history size
export HISTSIZE=10000000
export HISTFILESIZE=1000000
####

### fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
### fzf

### autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
### autojump

eval $(thefuck --alias)

### terminal prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
kubectl config current-context 2> /dev/null
have_current_context=$?
if [ $have_current_context -ne 0 ]; then
  export KUBE_PROMPT_ENABLED=false
else
  #PS1='\[\e[31;47m\]$(kubectl config current-context)\[\e[m\]\[\e[36;47m\]$(kubectl config view --minify --output 'jsonpath={..namespace}')\[\e[m\]\w\[\033[32m\]$(parse_git_branch)\[\033[00m\] \$ '
  export KUBE_PROMPT_ENABLED=true
fi
### terminal prompt

### custom alias
#### git
alias l="exa -la -snew"
alias ls="exa"
alias g="git"
alias ga="git add"
alias gst="git status"
alias gap="git add -p"
alias gco="git checkout"
alias gpr="git pull --rebase"
alias gp="git push"
alias game="git commit --amend"
alias gameo="git commit --amend --no-edit"
#### git
alias cat=bat
alias k=kubectl
alias gogo='cd $(find ~/go/src -type d -maxdepth 4 | fzf)'
alias got='cd $(find ~/projects/trials -type d -maxdepth 2 | fzf)'
alias tmuxx='tmuxp load $(ls ~/.tmuxp/*.yaml | rg ".*/.tmuxp/" -r "" | rg "\.yaml" -r "" | fzf) --yes'
alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf -m); do tmux kill-session -t \$s; done;"
alias ip="ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2"
alias list_objects='for a in $(find .git/objects -type f -depth 2 | rg -v "pack|info" | rg ".git/objects/|/" -r ""); do echo -n $a; echo -n " "; echo $(git cat-file -t $a); done;'
alias gcx="gco \$(git branch -a | sed -E 's/remotes\/([a-zA-Z-]*\/)//' | rg -v '\*|HEAD' | sort |uniq | fzf --select-1)"
alias baty="bat -l yaml"
### custom alias

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$HOME/.linkerd2/bin"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin
export GPG_TTY=$(tty)
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:/Users/dineshbalasubramanian/Library/Python/3.7/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.cargo/bin"
source ~/.scripts

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval "$(starship init bash)"

### temp
alias helm216=helm
alias helm=~/Downloads/darwin-amd64/helm
### temp
eval "$(zoxide init bash)"
