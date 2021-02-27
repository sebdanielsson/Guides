# Install tmux on Linux
Tmux is a terminal multiplexer. This lets you to run multiple terminal sessions simultaniously thus running multiple programs at the same time. And more importantly, this enables you to complete system updates even after a broken SSH connection since terminal sessions can be resumed.

## Installation
```
pacman -S tmux
```

## Usage
### Start a tmux session
```
tmux
```

### Show commands
```
Ctrl+b ?
```

### Start a named tmux session
```
tmux new -s <session-name>
```

### Detach from a tmux session
```
Ctrl+b d
```

### List sessions
```
tmux ls
```

### Attach to an existing session
```
tmux attach -t <session-name>
```

### Kill session
```
tmux kill-session -t <session-name>
or
Ctrl+b 
```

### Add a new pane to the right
```
Ctrl+b %
```

### Add a new pane to the bottom
```
Ctrl+b "
```

### Navigating the panes
```
Ctrl+b <Arrow-keys>
```

### Close a pane
```
Press Ctrl+d or type exit
```

### Summary
```
Ctrl+b c Create a new window
Ctrl+b w Switch window from a list
Ctrl+b 0 Switch to <window-number>
Ctrl+b , Rename current window
Ctrl+b % Split pane horizontally
Ctrl+b " Split pane vertically
Ctrl+b o Switch to the next pane
Ctrl+b ; Move between the current and previous pane
Ctrl+b x Close the current pane
```

## Credits
https://man7.org/linux/man-pages/man1/tmux.1.html