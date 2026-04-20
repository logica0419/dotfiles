# Editing Instructions

このファイルは、コード編集時の既定ルールです。過度にピーキーな制約を増やさず、再利用性の高いルールだけを残します。

## 読み方

- 上から順に読む。
- 迷ったら、先に「最優先ルール」と「ローカル設計メモ」を確認する。
- `roles/<role>/` 配下を編集する場合は、先に該当 `roles/<role>/notes.md` を確認してから、このファイルの該当章を読む。

## 最優先ルール

- 新しい制約を追記するのは、今後も再利用できるものだけにする。
- 追記するか迷う場合は、次の 4 条件で判定する。
  - 2つ以上の role や複数タスクで繰り返し効くか。
  - 守らないと不具合や lint 警告につながりやすいか。
  - 周辺ファイルを毎回読まなくても、先に知る価値があるか。
  - 例外が多すぎて、かえって判断を悪化させないか。
- 上の条件を満たしにくい内容は、グローバル instruction ではなくローカル設計メモへ置く。
- 一度決めた制約は、他の提案より優先する。

## ローカル設計メモ

- role 固有の運用メモは、`roles/<role>/notes.md` に置く。
- `roles/<role>/` 配下を編集する前に、該当 `notes.md` の有無を確認する。
- `notes.md` が存在する場合は、その role の変更提案より先に内容を参照する。
- タスク単位の補足は、該当 task の直近コメントで簡潔に残す。
- グローバル instruction には、role 固有の細かな手順を書きすぎない。
- `notes.md` には、周辺ファイルを読めば自明な事実を写経しない。
- `notes.md` には、グローバル instruction と同じ規則を重複して書かない。
- `notes.md` は「その role だけで有効な判断基準」と「例外条件」だけを残す。
- 追記前に次を確認する。
  - これは既存 task / template を見れば即わかる内容ではないか。
  - これは `.github/instructions/editing.instructions.md` に既にある規則ではないか。
  - これは将来の変更判断を助けるか、単なる現状説明にとどまっていないか。

## 編集の基本

- 既存コードの流儀を壊さず、最小差分で直す。
- 既存のコメントや命名に合わせ、勝手に統一しすぎない。
- 無関係な整形やリファクタリングはしない。
- 可能なら、変更理由が追いやすい単位で編集する。

## task 名

- `name` は簡潔に書く。目安は 3 から 8 語で、動詞から始める。
- 同じ意味の操作は同じ言い回しに寄せる。
- 「Check if」「Setup and configure」のような冗長な前置きは避ける。
- role 名や OS 名の重複は、文脈で明らかな場合は省略する。

## YAML と Ansible

- 役割ごとの task は既存の block 構成を優先する。
- 関心ごとが近い task は `block` でまとめる。特に `become` や `when` を共有できるときは block を優先する。
- OS 別処理は include_tasks や vars の分離で表現する。
- facts は既存の現行表現に合わせる。特に user_dir や user_uid の扱いを崩さない。
- top-level facts の非推奨を踏まえ、`ansible_user_dir` や `ansible_user_uid` ではなく `ansible_facts['user_dir']` / `ansible_facts['user_uid']` を使う。
- 変更がある task は、changed_when と failed_when を適切に付けて冪等性を保つ。
- role 内で `register` する変数名は、原則として `<role>_` 接頭辞を付ける。
- 変更時だけ実行したい後続処理は、通常 task の `when: <reg>.changed` ではなく `notify` + handler を優先する。
- become の有無は既存の責務分離に合わせる。
- Homebrew service の管理は `brew services` の直実行より `community.general.homebrew_services` を優先する。
- 同じ role 内では、同種 task のフィールド順をそろえる。
  - 推奨順: `name` -> `become` / `when` -> module -> module 引数 -> `changed_when` / `failed_when` -> `register` -> `notify`
  - module 引数の中も、`path` / `src` / `dest` などの対象指定を先、`state`、`mode`、その他を後ろに寄せる。
  - ただし package 系 module (`ansible.builtin.apt`, `community.general.homebrew`, `community.general.homebrew_cask`) では、`name` の直後に `state` を置く。
- 親ディレクトリが未作成の可能性がある多段パスを作る場合は、`loop` で親から段階的に `state: directory` を適用する。
  - `ansible.builtin.file` の `recurse` は、基本的に使わない。
- 外部インストーラが dotfile (`.profile` / `.bashrc` など) を自動編集する場合は、可能な限り無効化オプションを使い、dotfile 配布は `rc` role 側で一元管理する。

## files / templates / content の使い分け

- 配置可能なものは、できるだけ `roles/<role>/files` または `roles/<role>/templates` に置く。
- 変数展開が必要な設定は `templates` を使う。
- 変数展開が不要なら、`templates` ではなく `files` を優先する。
- `content` は 1 行以内で収まる内容を原則とする。
- 2 行以上になる場合は、特別な理由がない限り `files` か `templates` へ切り出す。
- dotfile を配布する場合でも、repo 内のソース名は先頭ドットなしを優先し、配置先 `dest` 側でドット付きファイル名にする。

## VS Code 設定の配置

- Linux の remote 環境（WSL / server）で VS Code 設定を配る場合は、`~/.vscode-server/data/Machine/settings.json` を優先する。
- Homebrew パス依存の設定値は、固定パスを直書きせず `check_os_brew_base_path` を使ってテンプレート化する。

## Bash スクリプト

- シェルスクリプトは冪等性を優先する。
- 可能な限り終了コードを明確にし、失敗時の挙動を曖昧にしない。
- 外部コマンドの存在確認は `command -v` を使って統一する。
- 存在確認時の出力抑制は `&>/dev/null` を既定とする。
- 変更後は、Ansible の custom module として使われる前提を崩さない。
- このリポジトリの `shell` モジュールとシェルスクリプトは、以下の基準で属性を付ける。
  - 2つ以上のコマンドを含む場合は `-e`
  - シェル変数を使う場合は `-u`
  - パイプラインを使う場合は `-o pipefail`
- ただし `run.sh` は例外として扱う。
- `ansible.builtin.shell` で Bash 専用記法を使う場合は、`args.executable` か POSIX 互換化のどちらで扱うかを先に決める。

## 文字列とスタイル

- 文字列は原則ダブルクォートを使う。
- シングルクォートは、シェルや YAML の都合で必要なときだけ使う。
- 既存のインデントと改行幅を保つ。
- YAML の特殊記号が増えすぎないように、同じ目的は同じ記法で書く。
- 長いコマンドや文字列は、無理にエスケープを増やすより `>-` や `|` を使って読みやすく保つ。

## 検証

- 変更後は、対象プレイブックの実行可否だけでなく `ansible-lint` でも確認する。
- lint の抑制コメントは最小限にし、理由が明確な場合だけ使う。
