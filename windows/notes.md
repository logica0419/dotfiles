# Windows Notes

`windows/run.ps1` の Windows 固有設計に関するメモ。

- Windows ホストの WSL 設定は `windows/files/wslconfig` を用いて、ユーザープロファイル直下の `%USERPROFILE%\.wslconfig` に配置する設計。WSL 内の `/etc/wsl.conf` とは役割を分離すること。
- `run.ps1` は同一ログオンユーザーを UAC で昇格して実行する前提で設計する。別ユーザー実行や SYSTEM 実行では `%USERPROFILE%` が意図しないプロファイルを指すため、この方式は避ける。
- `user_packages` と `machine_packages` の分離は、Windows でのインストールスコープに応じた運用判断であり、単一ループでの `winget install` よりも管理性を優先する。
