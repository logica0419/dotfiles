# Priority Rules

- 先に読むのはこのファイル。
- 次に `.github/instructions/editing.instructions.md` を読む。
- role 固有の変更では、該当 `roles/<role>/notes.md` を先に読む。

## 追記の原則

- instruction は必要最低限にとどめ、コンパクトにまとめる。
- 新しい制約は、その場で追記先を決めて反映する。
- 追記するのは、今後も再利用できる内容だけにする。
- 一度決めた制約は、他の提案より優先する。
- 追記の判断基準は次の通り。
  - 既存ファイル (タスク定義・テンプレートなど) を見れば即わかる内容ではないか。
  - 既存 instruction と重複していないか。
  - 実装手順や既存のコードの説明ではなく、判断基準や例外条件を記録しているか。
  - 将来の変更判断を改善する内容か。

## Global Instruction に追記する

- 2つ以上の role や複数タスクで繰り返し効く。
- 守らないと不具合や lint 警告につながりやすい。
- 周辺ファイルを毎回読まなくても、先に知る価値がある。

## Role の notes.md に追記する

- 1つの role だけで有効な判断基準や例外条件。
- グローバルに置くと例外が増えて判断を悪化させる内容。
- `roles/<role>/` 配下を編集する前に、該当 `notes.md` の有無を確認する。
- `notes.md` は実装手順ではなく、設計判断・例外・変更判断を残すためのもの。
- `notes.md` には、周辺ファイルで自明な事実や global instruction と同じ規則を書かない。

## Windows/notes.md の扱い

- `windows/` 配下の Windows 固有設計についても、`roles/<role>/notes.md` と同様に `windows/notes.md` を運用する。
- `windows/notes.md` は Windows 固有設計や例外を記録する場所で、運用ルールは `priority.instructions.md` にまとめる。
