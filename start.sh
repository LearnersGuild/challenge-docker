#!/bin/bash

function die {
  exitcode=${$2:-1}
  echo "$1" && exit $exitcode
}

test $FLOOBITS_API_KEY || die "FLOOBITS_API_KEY environment variable must be set"
test $FLOOBITS_SECRET || die "FLOOBITS_SECRET environment variable must be set"
test $FLOOBITS_USERNAME || die "FLOOBITS_USERNAME environment variable must be set"
test $FLOOBITS_WORKSPACE_URL || die "FLOOBITS_WORKSPACE_URL environment variable must be set"

# set up our Floobits credentials
cat > /home/dev/.floorc.json <<EOF
{
  "auth": {
    "floobits.com": {
      "api_key": "$FLOOBITS_API_KEY",
      "secret": "$FLOOBITS_SECRET",
      "username": "$FLOOBITS_USERNAME"
    }
  }
}
EOF
chmod 600 /home/dev/.floorc.json

# run floomatic and flootty
export SHELL=/bin/bash  # needed for flootty
floomatic --no-browser --share ${FLOOBITS_WORKSPACE_URL} . > /dev/null 2>&1 &
exec >/dev/tty 2>/dev/tty </dev/tty && \
  tmux new-session -d -n terminal1 "flootty --unsafe --url ${FLOOBITS_WORKSPACE_URL} --create terminal1" && \
  tmux new-session -n terminal2 "flootty --unsafe --url ${FLOOBITS_WORKSPACE_URL} --create terminal2"
