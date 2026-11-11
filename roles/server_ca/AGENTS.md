# server role

- `/var/log` is group-writable by syslog, so the logrotate rsyslog config needs `su root syslog`. Without it, daily rotation is skipped and logs grow without bound.
