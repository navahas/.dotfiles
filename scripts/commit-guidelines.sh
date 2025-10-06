#!/usr/bin/env bash

set -euo pipefail

# https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716
cat <<'EOF'
The commit message should be structured as follows:
<type>(<optional scope>): <description>
[optional body]
[optional footer(s)]

Valid types are:
  feat:     A new feature.
  fix:      A bug fix.
  docs:     Documentation changes.
  style:    Code style changes (formatting, missing semicolons, etc.).
  refactor: Code refactoring (neither fixes a bug nor adds a feature).
  test:     Adding or updating tests.
  chore:    Routine tasks like updating dependencies or build tools.
  build:    Changes affecting the build system or external dependencies.
  ci:       Changes to CI configuration files or scripts.
  perf:     Performance improvements.
  revert:   Reverting a previous commit.

Examples:
  feat(auth): add login functionality
  fix(api)!: resolve timeout issue
  docs(readme): update installation instructions
EOF
