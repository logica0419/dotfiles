# Copilot Instructions

このリポジトリは Ansible ベースの dotfiles 管理用です。Mac、WSL、server の複数環境を扱う前提で、既存の playbook と role の構成を崩さずに、最小限で一貫した変更を提案してください。

## 基本方針

- 既存の設計と流儀を優先し、不要な抽象化や大きな再構成はしない。
- 人向け README ではなく、Copilot が再利用しやすい instruction として書く。
- ansible-lint を前提にし、警告を増やす変更は避ける。
- 変更は局所的かつ可読性重視で、既存の命名やファイル配置に合わせる。
- 実装方針の詳細は `.github/instructions/editing.instructions.md` を最優先で参照する。
- role 固有の判断は、先に `roles/<role>/notes.md` を確認する。
- マシン間で共有すべきルールは、必ずこのリポジトリ内の instructions ファイルに書く。
- ローカルのメモリ機能にのみ置いた制約は、共有ルールとして扱わない。

## このリポジトリで重視すること

- OS ごとの差分は playbook と role の責務分離で表現する。
- 既存の facts 参照やテンプレートの命名規則を尊重する。
- Bash と YAML と Jinja2 が混在するので、言語ごとの慣習を混ぜない。
- 変更前提の提案では、既存の実装パターンと整合しているかを先に確認する。

## 追記の判断

- 新しい制約を追記するか迷ったら、まず再利用性を基準に判断する。
- 2つ以上の role や複数タスクで繰り返し効くなら、instruction に追記する。
- 周辺ファイルを読めば自明な事実や、role 固有の細かな手順は `notes.md` に置く。
- `notes.md` は、その role だけで有効な判断基準と例外条件に絞る。
- 追記対象の可否は `.github/instructions/editing.instructions.md` の最優先ルールに従う。

## 会話中に新しい制約が出た場合

- その場の回答だけで終わらせず、必要なら編集用の instructions ファイルか role の `notes.md` に追記する。
- 追記先は、その制約がグローバルに再利用できるか、role 固有かで決める。
- 一時的な事情や一回限りの回避策は追記しない。
