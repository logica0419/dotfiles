# Copilot Instructions

Ansible ベースの dotfiles 管理リポジトリ。Mac、WSL、server を対象に、既存の playbook と role 構成を崩さず、最小差分で一貫した変更を提案する。

## 基本方針

- 既存の設計と流儀を優先し、不要な抽象化や大きな再構成はしない。
- 人向け README ではなく、Copilot が再利用しやすい instruction に書く。
- ansible-lint を前提にし、警告を増やす変更は避ける。
- 変更は局所的かつ可読性重視で、既存の命名・配置に合わせる。
- 参照順は `priority.instructions.md` -> `editing.instructions.md` -> `roles/<role>/notes.md`。
- 共有すべきルールは、このリポジトリ内の instructions に書く。
- ローカルメモリだけに置いた制約は共有ルールとして扱わない。

## このリポジトリで重視すること

- OS ごとの差分は playbook と role の責務分離で表現する。
- 既存の facts 参照やテンプレートの命名規則を尊重する。
- Bash と YAML と Jinja2 が混在するので、言語ごとの慣習を混ぜない。
- 変更前に、既存実装パターンとの整合を確認する。

## 追記の判断

- 新しい制約が出たら、その場で追記先を決めて反映する。
- 複数 role / 複数タスクで再利用するなら global instruction に追記する。
- 1 role だけで有効な判断や例外は `roles/<role>/notes.md` に追記する。
- 周辺ファイルを見れば分かる事実や、一時対応は追記しない。
- 迷った場合の判定は `.github/instructions/priority.instructions.md` に従う。
