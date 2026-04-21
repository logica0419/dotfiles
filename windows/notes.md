# Windows Notes

- WSL 設定は `windows/files/wslconfig` を `%USERPROFILE%\.wslconfig` に配置し、WSL 内の `/etc/wsl.conf` とは役割分離する。
- `run.ps1` は同一ログオンユーザーを UAC 昇格して実行する前提とし、別ユーザー実行や SYSTEM 実行は避ける。
- パッケージ管理は `user_packages` / `machine_packages` を分離し、単一ループ化よりスコープごとの管理性を優先する。
- Startup の `winget_upgrade.bat` は `run.ps1` から毎回上書き生成し、パッケージ一覧の正は `run.ps1` の `$user_packages` とする。
