export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$HOME/.linkerd2/bin"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
# export GOROOT=$HOME/go
# export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go
export GPG_TTY=$(tty)
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:$HOME/Library/Python/3.7/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin"
source ~/scripts.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval "$(starship init bash)"
eval "$(direnv hook bash)"

#### to sync history across panes #####
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
#### to sync history across panes #####

#### increase history size
export HISTSIZE=10000000
export HISTFILESIZE=1000000
####

### Fetch in background
export PATH="$PATH:$HOME/dotfiles/"
export PROMPT_COMMAND="gitfetcher.sh; $PROMPT_COMMAND"
###

### fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
### fzf

### custom alias
#### git
alias g="git"
alias ga="git add"
alias gst="git status"
alias gap="git add -p"
alias gco="git checkout"
alias gpr="git pull --rebase"
alias gp="git push"
alias gpu="git push -u"
alias game="git commit --amend"
alias gameo="git commit --amend --no-edit"
alias gds="git diff --staged"
alias gc="git commit -s -S -m"
#### git
alias bat=batcat
alias cat=batcat
alias fd=fdfind
alias k=kubectl
alias ls="exa"
alias l="ls -la"
alias tmuxx='tmuxp load $(ls ~/.tmuxp/*.yaml | rg ".*/.tmuxp/" -r "" | rg "\.yaml" -r "" | fzf --select-1) --yes'
alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf -m); do tmux kill-session -t \$s; done;"
alias ip="ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2"
alias list_objects='for a in $(find .git/objects -type f -depth 2 | rg -v "pack|info" | rg ".git/objects/|/" -r ""); do echo -n $a; echo -n " "; echo $(git cat-file -t $a); done;'
alias gcx="gco \$(git branch -a | sed -E 's/remotes\/([a-zA-Z-]*\/)//' | rg -v '\*|HEAD' | sort |uniq | fzf --select-1)"
alias gtx="gco \$(git tag | sort |uniq | fzf --select-1)"
alias baty="bat -l yaml"
alias dst="docker ps"
alias oo="openrc"
alias git-copy="git open -p | pbcopy"
alias glow="glow -p -w $(tput cols)"

function cc() {
  code "${1:-.}"
}

alias gcmain="git checkout \$(git branch -a | rg '^  main|^  master')"

function gdx() {
 echo "Start Prune branches"
 git fetch --prune
 echo "Done Prune branches"
 echo "Will delete both local and remote branch"
 local branch=$(git branch -a | sed -E 's/remotes\/([a-zA-Z-]*\/)//' | rg -v '\*|HEAD' | sort |uniq | fzf | tr -d '[:space:]')
 [ -z "$branch" ] && echo "Choose one branch!" && return
 set +xe
 git push origin :$branch
 git branch -d $branch
}
### custom alias

### prunehistory on every new pane
prunehistory 2> /dev/null
### prunehistory on every new pane

export EDITOR=vim
export DOCKER_BUILDKIT=1
export BAT_THEME="DarkNeon"

# join zoom meeting
zoom() {
  name=$(cat $HOME/.zoom-ids.json | jq -r ".[] | .name" | fzf --query ${1:-""} --select-1 --height=10 --ansi --reverse)
  qparams=$(cat $HOME/.zoom-ids.json | jq -r ".[] | select(.name == \"$name\") | \"confno=\" + .id + \"&pwd=\" + .pwd ")
  open "zoommtg://zoom.us/join?$qparams"
}

zoom-join-add() {
  config_file=$HOME/.zoom-ids.json
  touch $config_file

  echo "Enter the meeting id"
  read meeting_id
  echo "Enter the name"
  read name
  echo "Enter the pwd"
  read pwd

  tmpDir=$(mktemp -d -t tmp.XXXXXXXXXX)
  echo "[{\"name\": \"$name\",\"id\": \"$meeting_id\",\"pwd\": \"$pwd\"}]" > $tmpDir/new-zoom-id.json

  jq -s '.[0] + .[1]' $config_file $tmpDir/new-zoom-id.json > $tmpDir/.zoom-ids.json
  cp $tmpDir/.zoom-ids.json $config_file

  echo "New entry added: {\"name\": \"$name\",\"id\": \"$meeting_id\",\"pwd\": \"$pwd\"}"
  rm -rf $tmpDir
}

alias rg="rg --hidden --glob '!.git'"
# complete -F __start_kubectl k

alias jwt="jq -R 'split(\".\") | .[1] | @base64d | fromjson' <<<"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/google-cloud-sdk/bin

source /usr/share/doc/fzf/examples/key-bindings.bash
alias tt="tmuxx"

source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

export DISPLAY=:0
