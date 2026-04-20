# mac role notes

- mac role では、後続 task が bash 前提で動けるように、シェル移行を先頭で完了させる。
- 既定シェルのパスは check_os の変数経由で解決し、OS 固有パスの直書きは避ける。
- .zsh\* の削除は「bash へ完全移行」を前提とした運用。zsh 併用要件が出た場合は、この方針を見直す。
- cask 追加時は推測名で入れず、Homebrew 公式一覧で token を確認してから追加する。
