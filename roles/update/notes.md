# update role notes

- 定期更新の自動実行は Linux 用プレイブック (`update-linux.yaml`) を参照する。
- macOS の更新は `update-mac.yaml` を使い、cask 更新は playbook 側で明示的に有効化する（`update` role の既定は無効）。
