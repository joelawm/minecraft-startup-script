#!/bin/sh
# Restart the Minecraft server with player warnings, then hand off to systemd.
# The actual stop/start is done by: systemctl restart minecraft

SESSION="minecraft"
SCREEN=/usr/bin/screen

warn () {
    $SCREEN -S "$SESSION" -X stuff "broadcast &c$1"
    $SCREEN -S "$SESSION" -X eval "stuff \015"
}

# If the server isn't running, just start it via systemd.
if ! $SCREEN -ls | grep -q "$SESSION"; then
    echo "Minecraft screen session not found; starting via systemd."
    systemctl restart minecraft
    exit 0
fi

warn "Server rebooting in 3 minutes."
sleep 60
warn "Server rebooting in 2 minutes."
sleep 60
warn "Server rebooting in 1 minute."
sleep 60
warn "Server rebooting..."
$SCREEN -S "$SESSION" -X stuff "kickall Rebooting. Please reconnect in one minute."
$SCREEN -S "$SESSION" -X eval "stuff \015"
sleep 5

# Let systemd perform the graceful stop and start (uses ExecStop/ExecStart).
systemctl restart minecraft
 