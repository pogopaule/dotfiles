#!/usr/bin/env bash
SESSION=$(tmux list-sessions -F "#S" | fzf --prompt="Session: ")
if [ -n "$SESSION" ]; then
  tmux switch-client -t "$SESSION"
fi
