#!/bin/bash

floomatic --no-browser --share https://floobits.com/jeffreywescott/foo . > /dev/null 2>&1 &
export SHELL=/bin/bash
tmux new-session -n foo 'flootty --unsafe --url https://floobits.com/jeffreywescott/foo --create terminal1'
