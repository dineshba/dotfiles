#!/usr/bin/env bash

function fetch_in_background() {
  {
    echo "fetching git in background"
    eval "git fetch --quiet" &> /dev/null
  }&
}

GIT_REPO="$PWD/.git"
if [[ -e $GIT_REPO ]]; then
  FETCH_HEAD="$GIT_REPO/FETCH_HEAD"
  if [[ -e "${FETCH_HEAD}" ]]; then
    
    FETCH_TIMEOUT=5 #minutes after which check again
    
    perl -e '((time - (stat("'"${FETCH_HEAD}"'"))[9]) / 60) > '"${FETCH_TIMEOUT}"' && exit(0) || exit(1)'
    x="$?"
    if [[ $x == 0 ]]; then
      if [[ -n $(git remote show) ]]; then
        (
          fetch_in_background
          disown -h
        )
      fi
    fi
  else 
    # echo ".git/FETCH_HEAD not found"
    fetch_in_background
    disown -h
  fi
fi
