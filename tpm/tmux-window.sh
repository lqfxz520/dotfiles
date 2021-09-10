#!/bin/sh
# session_name = $(tmux display-message -p '#S')
tmux new-window -t 0:0 -n 'BUILD'
tmux new-window -t 0:1 -n 'OPEN'
tmux new-window -t 0:2 -n 'ERP'
tmux new-window -t 0:3 -n 'OPS'
tmux new-window -t 0:4 -n 'YJYZ'

tmux split-window -v -t 0:0
tmux split-window -h -t 0:0
tmux select-pane -t:0.0
tmux split-window -h -t 0:0

tmux send-keys -t:0.0 'cd ~/open.web.portal && npm run serve' ENTER
tmux send-keys -t:0.1 'cd ~/erp.web.portal && npm run serve' ENTER
tmux send-keys -t:0.2 'cd ~/ops.web.portal && npm run serve' ENTER
tmux send-keys -t:0.3 'cd ~/yjyz.h5.portal && npm run serve' ENTER


tmux send-keys -t:1 'cd ~/open.web.portal' ENTER
tmux send-keys -t:2 'cd ~/erp.web.portal' ENTER
tmux send-keys -t:3 'cd ~/ops.web.portal' ENTER
tmux send-keys -t:4 'cd ~/yjyz.h5.portal' ENTER

# tmux select-window -t workspace:1
# tmux -2 attach-session -t workspace
