# server role notes

- `/var/log` が group syslog 書き込み可のため、logrotate の rsyslog 設定には `su root syslog` が必要。設定しないと日次ローテーションが skipped になりログが無制限に肥大する。
