#!/bin/bash

function die {
  exitcode=${$2:-1}
  echo "$1" && exit $exitcode
}

test $FLOOBITS_USER || die "FLOOBITS_USER environment variable must be set"
test $FLOOBITS_WORKSPACE || die "FLOOBITS_WORKSPACE environment variable must be set"

FLOOBITS_URL="https://floobits.com/${FLOOBITS_USER}/${FLOOBITS_WORKSPACE}"
export SHELL=/bin/bash

floomatic --no-browser --share ${FLOOBITS_URL} . > /dev/null 2>&1 &
tmux new-session -n foo "flootty --unsafe --url ${FLOOBITS_URL} --create terminal1"
