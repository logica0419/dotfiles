# dotfiles

環境構築スクリプト

> Windows環境は[`./windows`](windows/README.md)を参照

## 下準備

### SSH鍵

Bitwardenに以下のアイテムをSSH Keyタイプで登録

- `SSH Signing Key`: Git署名用 (長期利用)
- `SSH Auth Key`: 認証用 (使い捨て可)

### sudoがパスワード無しで通るようにする

```bash
sudo visudo
```

Ubuntu (wsl・server) の場合

```diff
- %sudo   ALL=(ALL:ALL) ALL
+ %sudo   ALL=(ALL:ALL) NOPASSWD:ALL
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
  - wsl (Ubuntu 26.04 on WSL2環境用)
  - server (Ubuntu 26.04 on 自宅サーバー用)
  - server-ca (【お仕事】Ubuntu 24.04 on CAインターン開発環境用)
  - sdplane (【お仕事】Ubuntu 24.04 on sdplane開発環境用)

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
- Amphetamine
