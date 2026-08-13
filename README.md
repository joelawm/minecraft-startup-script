# Minecraft startup script
Feel free to use this and adapt to your system, im running it on Ubuntu 20.4 lts.
Also make sure you're running the Essentials Plugin for Bukkit, this uses its broadcast system, you can change it if you'd like, but essnetials in my mind is essential.
https://dev.bukkit.org/projects/essentialsx It may change over the years, a couple years ago it was called essentials, now essentialsx. 

## How it works
The server lifecycle is managed by **systemd** via `minecraft.service`. The
scripts just do player warnings and then hand off to systemd:

- `start.sh` — launches the server in a detached `screen` session. Called by
  systemd as `ExecStart`.
- `stop.sh` — sends the Minecraft `stop` command and waits for the session to
  end. Called by systemd as `ExecStop`.
- `restart.sh` — warns players, then runs `systemctl restart minecraft`.
- `shutdown.sh` — warns players, then runs `systemctl stop minecraft`.

## Install
```sh
# Copy the unit into systemd and enable it.
sudo cp minecraft.service /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft
```

## Manual control
```sh
sudo systemctl start minecraft     # start
sudo systemctl stop minecraft      # stop (graceful, via stop.sh)
sudo systemctl restart minecraft   # restart (graceful)
sudo systemctl status minecraft    # check status
```

## Cron Job
```
0 0,6,12,18 * * * /location/restart.sh >/dev/null 2>&1
```
This restarts the server every 6 hours, you can add more as needed, my system has 32GBs of ram.
