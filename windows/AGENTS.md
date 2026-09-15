# Windows

- Deploy `windows/files/wslconfig` to `%USERPROFILE%\.wslconfig`, separate from `/etc/wsl.conf` inside WSL.
- Run `run.ps1` as the same logged-on user with UAC elevation, not another user or SYSTEM.
- Keep `user_packages` / `machine_packages` split; regenerate Startup `winget_upgrade.bat` from `$user_packages` every time.
