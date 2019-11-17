#!/usr/bin/bash
if [ -x /usr/local/bin/xkeysnail ]; then
    xhost +SI:localuser:root
    sudo -u root DISPLAY=:0.0 /usr/local/bin/xkeysnail /etc/opt/xkeysnail/config.py
fi
