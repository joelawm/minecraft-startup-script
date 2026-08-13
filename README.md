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
The cron job must run as **root** because `restart.sh` calls `systemctl restart
minecraft`, which requires root permissions. The cleanest way is to drop a file
in `/etc/cron.d/`:

```sh
sudo nano /etc/cron.d/minecraft
```

Paste this (note the `deltagi` username field — files in `/etc/cron.d/` require
it, and the path must point to where you installed `restart.sh`):

```cron
# Restart Minecraft server every 6 hours (as root, so systemctl works)
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

0 0,6,12,18 * * * deltagi /home/deltagi/Documents/GitHub/minecraft-startup-script/restart.sh >/dev/null 2>&1
```

Make the file world-readable (cron ignores files it can't read):

```sh
sudo chmod 644 /etc/cron.d/minecraft
```

No restart needed — cron picks up files in `/etc/cron.d/` automatically. Avoid
giving the file a `.sh` extension, as cron ignores those.

This restarts the server every 6 hours, you can add more as needed, my system has 32GBs of ram.
