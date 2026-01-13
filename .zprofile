# Auto-start X (i3) after TTY login
if [ -z "$DISPLAY" ] && [ -z "$SSH_CONNECTION" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec startx
fi

