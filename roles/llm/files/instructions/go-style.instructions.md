---
name: Go Style
description: "Write simple, readable Go with explicit failure paths. Use when writing or refactoring Go code, modules, or CLI tools."
applyTo: "**/*.go, **/go.mod"
---

# Go Style

- Keep `go` directive at the minimal version verified by `mingo`; pin `toolchain` separately when a newer SDK builds it.
- Wrap failures with `github.com/k1LoW/errors` as `errors.WithStack(fmt.Errorf("...: %w", err))`; keep messages lowercase without punctuation. Use `errors.As` for sentinel checks such as `viper.ConfigFileNotFoundError`.
- Prefer `log/slog` with `TextHandler` for console and `JSONHandler` for json; send normal logs to stdout and failure logs to stderr.
- Keep `viper` keys in one kebab-case form; `Unmarshal` honors `mapstructure` only, so do not rely on `yaml`/`json` tags.
- Collapse a `TrimSpace` + `TrimRight`/`Trim` pair into one line when it stays readable; keep `if !ok { return nil }` guards compact without extra blank lines.
- Keep `switch` directly attached to its first `case`; separate remaining `case` blocks with one blank line.
