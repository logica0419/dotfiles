# Editing Instructions

Copilot 向けの詳細編集ルール。先に `.github/instructions/priority.instructions.md` を読み、role 固有の変更では `roles/<role>/notes.md` を先に確認する。

## 基本

- 最小差分で直す。
- 既存の命名・構成・コメントに合わせる。
- 無関係な整形やリファクタリングはしない。
- 変更理由が追いやすい単位で編集する。
- 編集中に新しい制約が見つかったら、その場で `priority.instructions.md` / このファイル / `notes.md` のいずれかに追記する。

## task 名

- `name` は簡潔にする。目安は 3 から 6 語、動詞始まり。
- 同じ目的の task は同じ名前に寄せる。
- 新規命名前に既存 role の同目的 task 名を検索して再利用する。
- 冗長な前置き（例: `Check if`, `Setup and configure`）は避ける。
- role 名や OS 名の重複は、文脈で明らかなら省略する。
- 迷ったら次の動詞を優先する。
  - `Configure`: 設定全体の適用（例: `Configure updater service`）
  - `Create`: ディレクトリや空ファイルの作成（例: `Create SSH directory`）
  - `Deploy`: 設定ファイルやテンプレートの配置（例: `Deploy VS Code settings`）
  - `Install`: パッケージやコマンドの導入（例: `Install code package`）
  - `Enable`: サービスや機能の有効化（例: `Enable and restart updater service`）
  - `Get`: 状態取得のみで変更しない処理（例: `Get current workspace path`）
- 既存の `Copy` / `Move` / `Put` / `Setup` / `Check` は、新規追加時は上の語彙へ寄せる。
- 共通で再利用する名詞句は表記を固定する（`SSH`, `VS Code`, `workspace path`, `updater service`）。

## Ansible と YAML

- 関心が近い task は `block` にまとめる。
- OS 差分は `include_tasks` や `vars` 分離で表現する。
- facts は `ansible_facts.<fact_name>` を使う。
- 変更のある task には `changed_when` / `failed_when` を適切に付ける。
- `register` 変数名は原則 `<role>_` 接頭辞を付ける。
- 変更時だけ走らせる処理は、`when: <reg>.changed` より `notify` + handler を優先する。
- Homebrew service は `brew services` 直実行より `community.general.homebrew_services` を優先する。
- 同一 role では同種 task のフィールド順をそろえる。
  - 推奨順: `name` -> `become` / `when` -> module -> module 引数 -> `changed_when` / `failed_when` -> `register` -> `notify`
  - package 系 module は `name` の直後に `state` を置く。
- 多段ディレクトリは親から順に `state: directory` で作成する。
- `ansible.builtin.file` の `recurse` は原則使わない。
- 外部インストーラが dotfile を自動編集する場合は可能な限り無効化し、dotfile 配布は `rc` role へ寄せる。

## files / templates / content

- 可能なものは `roles/<role>/files` または `roles/<role>/templates` に置く。
- 変数展開が必要なら `templates`、不要なら `files` を優先する。
- `content` は原則 1 行以内。2 行以上は `files` / `templates` へ切り出す。
- dotfile 配布時も、repo 内ソースは先頭ドットなしを優先し、`dest` 側でドット付きにする。
- Linux remote（WSL / server）の VS Code 設定は `~/.vscode-server/data/Machine/settings.json` を優先する。
- Homebrew 依存のパス値は固定値を直書きせず `check_os_brew_base_path` を使う。

## Bash

- 冪等性を優先する。
- 終了コードを明確にし、失敗挙動を曖昧にしない。
- 外部コマンド確認は `command -v`、出力抑制は `&>/dev/null` で統一する。
- `shell` とスクリプトは必要に応じて `-e` / `-u` / `-o pipefail` を付ける（`run.sh` は例外）。
- `ansible.builtin.shell` で Bash 専用記法を使う場合は、`args.executable` を使うか POSIX 互換にするかを先に決める。

## 文字列と検証

- 文字列は原則ダブルクォート。
- シングルクォートは必要時のみ使う。
- 既存のインデントと改行幅を保つ。
- 同じ目的は同じ記法で書き、YAML の特殊記号を増やしすぎない。
- 長いコマンドや文字列は、過剰エスケープより `>-` や `|` を使う。
- 変更後は対象 playbook 実行可否に加えて `ansible-lint` で確認する。
- `noqa` は最小限にし、理由が明確な場合だけ使う。
