#!/bin/bash

floomatic --no-browser --share https://floobits.com/jeffreywescott/foo . > /dev/null 2>&1 &
export SHELL=/bin/bash
flootty --unsafe --url https://floobits.com/jeffreywescott/foo --create terminal1
