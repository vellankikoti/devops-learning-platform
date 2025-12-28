---
sidebar_position: 3
title: Script Structure and Best Practices
---

# Script Structure: The Professional Template

Every good script follows a structure. Learn it once. Use it forever.

**Here's the thing: Structure makes scripts readable. Maintainable. Professional. Use it.**

## The Basic Structure

```bash
#!/bin/bash
# Script description
# Usage: ./script.sh [options]

# Configuration
set -euo pipefail

# Functions
function_name() {
    # Function body
}

# Main
main() {
    # Script logic
}

main "$@"
```

**That's it. That's the structure.**

## The Shebang

```bash
#!/bin/bash
```

**What it does**: Tells Linux which interpreter to use.

**My take**: Always include it. Always. Without it, scripts might not run.

## set -euo pipefail

```bash
set -euo pipefail
```

**What it does**:
- `-e` = Exit on error
- `-u` = Exit on undefined variable
- `-o pipefail` = Fail if any pipe command fails

**My take**: Use this. Always. It catches errors early. Makes scripts more reliable.

## Script Directory

```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "$0")"
```

**What it does**: Gets the directory where the script is located.

**My take**: Useful for relative paths. Use it when scripts reference other files.

## Configuration Section

```bash
# Configuration
SOURCE_DIR="${SOURCE_DIR:-/default/path}"
BACKUP_DIR="${BACKUP_DIR:-/backup}"
MAX_BACKUPS=7
```

**The `${VAR:-default}`**: Uses VAR if set, otherwise uses default.

**My take**: Put configuration at the top. Makes it easy to modify.

## Functions Section

```bash
# Functions
log() {
    local level="$1"
    shift
    local message="$*"
    echo "[$(date)] [$level] $message"
}

backup_file() {
    local file="$1"
    cp "$file" "${file}.backup"
}
```

**My take**: Put functions before main. Organizes code. Makes it readable.

## Main Function

```bash
main() {
    # Script logic here
    validate_input
    process_files
    cleanup
}

main "$@"
```

**The `"$@"`**: Passes all arguments to main.

**My take**: Put main logic in a function. Makes scripts testable. Makes structure clear.

## Comments

```bash
# This is a comment
# Explain WHY, not WHAT
```

**My take**: Comment why, not what. Code should be self-explanatory. Comments explain decisions.

## Error Handling

```bash
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

if [ ! -f "$file" ]; then
    error_exit "File not found: $file"
fi
```

**My take**: Handle errors. Don't let scripts fail silently. Tell users what went wrong.

## Logging

```bash
log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*"
}

log "INFO" "Script started"
log "ERROR" "Something went wrong"
```

**My take**: Log important events. Makes debugging easier. Makes scripts professional.

## Complete Example

```bash
#!/bin/bash
# Backup script
# Usage: ./backup.sh [source] [destination]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${1:-/home/ubuntu/data}"
BACKUP_DIR="${2:-/backup}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

backup() {
    local source="$1"
    local dest="$2"
    
    if [ ! -d "$source" ]; then
        echo "Error: Source directory not found: $source"
        exit 1
    fi
    
    log "Backing up $source to $dest"
    cp -r "$source" "$dest"
    log "Backup complete"
}

main() {
    log "Script started"
    backup "$SOURCE_DIR" "$BACKUP_DIR"
    log "Script completed"
}

main "$@"
```

**My take**: This is a good structure. Follow it. Your scripts will be better.

## Common Mistakes (I've Made These)

1. **Forgetting shebang**: Scripts might not run. Always include `#!/bin/bash`.

2. **Not using `set -euo pipefail`**: Scripts continue after errors. Use it.

3. **No error handling**: Scripts fail silently. Handle errors. Tell users what went wrong.

4. **No logging**: Hard to debug. Add logging. Makes life easier.

5. **Everything in main**: No functions. Hard to read. Organize with functions.

## What's Next?

Now that you understand script structure, you can write professional scripts. Or learn about [Variables](/docs/shell-scripting/variables/variable-basics) to store data.

---

> **Personal note**: When I started, my scripts had no structure. Everything was in one big block. Then I learned structure. Now my scripts are organized. Readable. Maintainable. Structure matters.
