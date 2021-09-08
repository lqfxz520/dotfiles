#!/bin/sh
tmux new-session -d -s workspace

# tmux new-window -t workspace:0 -n 'BUILD'
tmux new-window -t workspace:1 -n 'OPEN'
tmux new-window -t workspace:2 -n 'ERP'
tmux new-window -t workspace:3 -n 'OPS'
tmux new-window -t workspace:4 -n 'YJYZ'

tmux select-window -t workspace:1
tmux -2 attach-session -t workspace
