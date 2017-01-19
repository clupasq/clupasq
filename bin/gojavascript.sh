#!/bin/bash

NAME=nodetest
FILENAME=${1-$HOME/test.js}

if tmux has-session -t $NAME 2> /dev/null; then
  # session already exists; connect to it
  tmux attach -t $NAME
  exit
fi

touch $FILENAME

# session does not exist; let's create it
tmux new-session -s $NAME -d

tmux send-keys -t $NAME "vim $FILENAME" C-m

tmux split-window -h -t $NAME
WATCH_COMMAND="while true; do inotifywait -e MODIFY $FILENAME; clear; time node $FILENAME; done"
tmux send-keys -t $NAME "$WATCH_COMMAND" C-m

# go back to first pane
tmux select-pane -t :.+

tmux -2 attach-session -t $NAME

