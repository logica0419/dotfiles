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

Linuxの場合

```diff
- %sudo ALL=(ALL) ALL
+ %sudo ALL=(ALL) NOPASSWD:ALL
```

MacOSの場合

```diff
- %admin          ALL = (ALL) ALL
+ %admin          ALL = (ALL) NOPASSWD:ALL
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

## その他

### 【server】UEFI設定

serverに関しては、UEFIで以下の設定を行う

- OC Tweaker
  - CPU Configuration
    - Boot Performance Mode: Max Battery
- Advanced
  - UEFI Setup Style: Advanced Mode
  - CPU Configuration
    - CPU C States Support: Enabled
      - CFG Lock: Disabled
      - それ以外: Enabled
  - Chipset Configuration
    - PCI Express Native Control: Enabled
    - ASPM: L0sL1
    - PCH PCIE ASPM Support: L1
    - DMI ASPM Support: Enabled
    - PCH DMI ASPM Support: Enabled
    - Onboard HD Audio: Disabled
    - Internal Speaker: Disabled
    - Onboard WAN Device: Disabled
    - Deep Sleep: Enabled in S4-S5
  - H/W Monitor
    - CPU Fan 1 Setting: Silent Mode
    - CPU Fan 2 Setting: Silent Mode
  - Boot
    - Fast Boot: Ultra Fast

### 【Mac】手動でインストールするもの

Macは手動インストールが必要なものがある

- 各種フォント類
  - 特にcica
- DockLock Lite
