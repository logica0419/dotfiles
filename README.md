# dotfiles

環境構築スクリプト

> Windows環境は[`./windows`](windows/README.md)を参照

## 下準備

### ssh鍵を用意する

- `~/.ssh/id_ed25519`
  - Permission: 0600
- `~/.ssh/id_ed25519.pub`
  - Permission: 0644

### sudoがパスワード無しで通るようにする

```bash
sudo visudo
```

```diff
- %sudo ALL=(ALL) ALL
+ %sudo ALL=(ALL) NOPASSWD:ALL
```

### Requirements

- `curl`
- `bash`

## 実行

```bash
curl -L https://raw.githubusercontent.com/logica0419/dotfiles/main/import.sh -o /tmp/import.sh && ENV={environment} bash /tmp/import.sh
```

- {environment} について
  - mac (MacOS環境用)
  - wsl (WSL2環境用)
  - server (開発自宅鯖用)
