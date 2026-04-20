# completion role notes

このメモは `roles/completion` 固有の設計方針をまとめる。

- Bash completion を有効化する場合、macOS では Homebrew の `bash-completion@2` と `/opt/homebrew/etc/profile.d/bash_completion.sh` または `/usr/local/etc/profile.d/bash_completion.sh` を優先して扱う。
- completion ファイルを生成する task では、プレイブックの導入順が保証されるなら存在確認を省いて fail fast に寄せてよい。
