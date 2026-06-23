# Windows

## 下準備

### ssh鍵を用意する

Gitの署名用

- `~/.ssh/id_ed25519.pub`
  - Permission: 0644

## 実行

PowerShellを管理者権限で起動し、以下のコマンドを実行

```powershell
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/logica0419/dotfiles/refs/heads/main/windows/run.ps1").Content
```

## 手動でインストールするもの

wingetでインストールできない以下のソフトは手動でインストール

- 各種フォント類
  - 特にcica
- Open Hardware Monitor
- NVIDIA App
- WSL本体 (wsl --install ubuntu)
- ASRock BIOS更新
- ASRock APP Shop
- AMDドライバ 更新
- aescripts + aeplugins
- xrecode II
- rekordbox
- Steinberg Download Assist
- Native Access
- Omnisphere2
- Serum2
- FabFilter系
- Plugin Boutique系
- Sausage Fattener
- Nicky Romero Kickstart
- VALORANT
- Battle.net
- Ollama
