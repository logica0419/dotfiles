# mac role

- Complete the shell migration first so later tasks can assume bash; resolve the shell path via check_os variables.
- Removing .zsh* assumes full bash migration; revisit if any scripts or applications depend on zsh for functionality.
- Confirm cask tokens in the official Homebrew list; do not guess.
