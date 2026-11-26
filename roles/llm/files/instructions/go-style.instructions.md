---
name: Go Style
description: "Write simple, readable Go with explicit failure paths. Use when writing or refactoring Go code, modules, CLI tools, or documenting exported APIs."
applyTo: "**/*.go, **/go.mod"
---

# Go Style

## Module and toolchain

- Keep `go` directive at the minimal version verified by `mingo`; pin `toolchain` separately when a newer SDK builds it.
- Upgrade dependencies to the latest by default; keep one behind only for a stated reason and ask about each one. Upgrade transitives only insofar as the build and tests stay green.

## Errors

- Wrap failures with `github.com/k1LoW/errors` as `errors.WithStack(fmt.Errorf("...: %w", err))`.
- Use `errors.As` (or `errors.AsType` on Go 1.26+) for sentinel checks such as `viper.ConfigFileNotFoundError`.

## Logging

- Prefer `log/slog` with `TextHandler` for console and `JSONHandler` for json; send normal logs to stdout and failure logs to stderr.
- Write log messages as full sentences; report a failure as `Failed to ...`.

## Configuration

- Keep `viper` keys in one kebab-case form; `Unmarshal` honors `mapstructure` only, so do not rely on `yaml`/`json` tags.

## Stdlib

- Prefer the current stdlib over older or third-party equivalents: `strings.SplitSeq`, `cmp.Or`, `slices.Sorted(maps.Keys(...))`.

## Formatting

- Collapse a `TrimSpace` + `TrimRight`/`Trim` pair into one line when it stays readable; keep `if !ok { return nil }` guards compact without extra blank lines.
- Take a range element by pointer as `item := &items[i]`, to avoid copying it if applicable.
- Group declarations into a `var (...)` block wherever they can be grouped; write a single `var x T` only when they cannot.
- Separate the groups inside a const block with a blank line.
- Keep `switch` directly attached to its first `case`; separate remaining `case` blocks with one blank line.

## Documentation

- Document each exported type, constant, function, and method with one line stating what it does; add a sub-line only for implementation Why / Why not.
- Write doc comments in third-person present, with a template per return shape: `X reports whether ...` for bool helpers, `X returns ..., or nil when ...` for nil-able lookups.
- Carry the doc of a struct field that needs a why as a trailing comment on its line, repeating the field name as the subject.
- Place package comments in `{package}.go` with a one-line main description.
