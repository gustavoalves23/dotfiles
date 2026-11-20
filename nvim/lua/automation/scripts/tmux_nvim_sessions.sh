#!/bin/sh

self_pid=${1:-0}
session_name=$(tmux display-message -p '#S')
pane_pids=$(tmux list-panes -s -t "$session_name" -F '#{pane_pid}' | tr '\n' ' ')

ps -axo pid=,ppid=,comm= | awk -v panes="$pane_pids" -v self="$self_pid" '
  function pane_of(q) {
    while (q in ppid && q > 1) {
      if (q in pane) return q
      q = ppid[q]
    }
    return ""
  }
  {
    pid = $1; ppid[pid] = $2
    name = $3; sub(".*/", "", name)
    if (name == "nvim") nvim[pid] = 1
  }
  END {
    n = split(panes, list, " ")
    for (i = 1; i <= n; i++) pane[list[i]] = 1
    own = pane_of(self)
    for (p in nvim) {
      f = pane_of(p)
      if (f != "" && f != own) found[f] = 1
    }
    c = 0
    for (k in found) c++
    print c
  }'
