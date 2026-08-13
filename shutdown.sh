#!/bin/sh
# Shut down the Minecraft server with player warnings, then hand off to systemd.
# The actual stop is done by: systemctl stop minecraft

SESSION="minecraft"
SCREEN=/usr/bin/screen

warn () {
    $SCREEN -S "$SESSION" -X stuff "broadcast &c$1"
    $SCREEN -S "$SESSION" -X eval "stuff \015"
}

# If the server isn't running, nothing to do.
if ! $SCREEN -ls | grep -q "$SESSION"; then
    echo "Minecraft screen session not found."
    systemctl stop minecraft 2>/dev/null
    exit 0
fi

warn "Server shutting down in 2 minutes."
sleep 60
warn "Server shutting down in 1 minute."
sleep 60
warn "Server shutting down..."
$SCREEN -S "$SESSION" -X stuff "kickall Shutting down. Please reconnect later."
$SCREEN -S "$SESSION" -X eval "stuff \015"
sleep 5

# Let systemd perform the graceful stop (uses ExecStop).
systemctl stop minecraft
 