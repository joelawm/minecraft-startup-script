#!/bin/sh
# Gracefully stop the Minecraft server (no player warnings).
# Used by systemd as ExecStop and safe to call manually.

SESSION="minecraft"
SCREEN=/usr/bin/screen

# Only act if the screen session exists.
if ! $SCREEN -ls | grep -q "$SESSION"; then
    echo "Minecraft screen session not found; nothing to stop."
    exit 0
fi

# Send the Minecraft "stop" command and submit it with Enter.
$SCREEN -S "$SESSION" -X stuff "stop"
$SCREEN -S "$SESSION" -X eval "stuff \015"

# Wait for the server to shut down (screen session ends), up to 60s.
for i in $(seq 1 60); do
    if ! $SCREEN -ls | grep -q "$SESSION"; then
        echo "Minecraft server stopped cleanly."
        exit 0
    fi
    sleep 1
done

# Fallback: force-quit the screen session if it's still hanging.
echo "Server did not stop in time; force-quitting screen session."
$SCREEN -S "$SESSION" -X quit 2>/dev/null
exit 0
