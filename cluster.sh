#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

export TERM=screen-256color-bce

tmux new-session -d -s redis-cluster

tmux send-key -t redis-cluster 'cd ./7001' Enter 'redis-server redis.conf' Enter
tmux split-window -t redis-cluster
tmux send-key -t redis-cluster 'cd ./7002' Enter 'redis-server redis.conf' Enter

tmux new-window -t redis-cluster -n ''
tmux send-key -t redis-cluster 'cd ./7003' Enter 'redis-server redis.conf' Enter
tmux split-window -t redis-cluster
tmux send-key -t redis-cluster 'cd ./7004' Enter 'redis-server redis.conf' Enter

tmux new-window -t redis-cluster -n ''
tmux send-key -t redis-cluster 'cd ./7005' Enter 'redis-server redis.conf' Enter
tmux split-window -t redis-cluster
tmux send-key -t redis-cluster 'cd ./7006' Enter 'redis-server redis.conf' Enter

# UNCOMMENT ANY TO ADD MORE NODES

# tmux new-window   -t redis-cluster -n ''
# tmux send-key     -t redis-cluster 'cd ./7007'                    Enter 'redis-server redis.conf'                  Enter
# tmux split-window -t redis-cluster
# tmux send-key     -t redis-cluster 'cd ./7008'                    Enter 'redis-server redis.conf'                  Enter

# tmux new-window   -t redis-cluster -n ''
# tmux send-key     -t redis-cluster 'cd ./7009'                    Enter 'redis-server redis.conf'                  Enter
# tmux split-window -t redis-cluster
# tmux send-key     -t redis-cluster 'cd ./7010'                    Enter 'redis-server redis.conf'                  Enter

# tmux new-window   -t redis-cluster -n ''
# tmux send-key     -t redis-cluster 'cd ./7011'                    Enter 'redis-server redis.conf'                  Enter
# tmux split-window -t redis-cluster
# tmux send-key     -t redis-cluster 'cd ./7012'                    Enter 'redis-server redis.conf'                  Enter

if [ -z "$NESTED_TMUX" ]; then
  tmux attach-session -t redis-cluster
else
  tmux switch-client -t redis-cluster
fi
