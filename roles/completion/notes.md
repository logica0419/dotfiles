# completion role notes

このメモは `roles/completion` 固有の設計方針をまとめる。

- Bash completion を有効化する場合、macOS では Homebrew の `bash-completion@2` と `/opt/homebrew/etc/profile.d/bash_completion.sh` または `/usr/local/etc/profile.d/bash_completion.sh` を優先して扱う。
- completion ファイルを生成する task では、プレイブックの導入順が保証されるなら存在確認を省いて fail fast に寄せてよい。
- completion の配置先は `{{ ansible_facts.user_dir }}/.local/share/bash-completion/completions` に固定する。
- 多段ディレクトリは単発作成にせず、親から順に `state: directory` を適用して存在保証する。
- Terraform は completion 用ファイルに `complete -C "$(command -v terraform)" terraform` を配置する。
- Bun は `bun completions` の出力を completion 用ファイルに保存する。
