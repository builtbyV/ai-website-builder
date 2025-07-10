# Updates for Cross-Platform Support (Mac, Windows, Linux)

## Overview
Remove Mac-only restrictions to support all platforms (Mac, Windows via Git Bash, and Linux).

---

## 1. Updates for setup.sh

### Remove OS Check (Lines 1-36)

**Current:**
```bash
# Supports: macOS only (for now)

# Helper functions for consistent output
print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Check if running on macOS
check_os() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This installer only supports macOS. Detected OS: $OSTYPE"
        exit 1
    fi
    print_success "macOS detected"
}

# Check OS compatibility first
check_os
echo ""
```

**Change to:**
```bash
# This script installs AI coding assistants (Claude Code & Gemini CLI & OpenAI Codex CLI)
# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}AI Website Builder Setup${NC}"
echo "========================="
echo ""
```

**Rationale:** 
- The script works on all platforms with bash (including Git Bash on Windows)
- No need for OS-specific checks
- Keeps helper functions but removes OS restriction

### Update QUICK_START.txt Terminal Commands (Line ~300)

**Current:**
```
- Ctrl+C          # Stop something running
```

**Change to:**
```
- Ctrl+C (or Command+C on Mac)  # Stop something running
```

**Rationale:** Mac users often use Command+C, so include both options.

---

## 2. Updates for README.md

### Update "What You Need" Section (Lines 35-40)

**Current:**
```markdown
### What You Need:
- A Mac computer (Support for Windows coming soon!)
- Internet connection
- A free GitHub account (needed later when you publish your site)
- 10 minutes to set up
- That's it!
```

**Change to:**
```markdown
### What You Need:
- A computer with internet
- A free GitHub account (needed later when you publish your site)
- 10 minutes to set up
- That's it!
```

**Rationale:** Remove Mac-only restriction since we support all platforms.

### Update "Opening Terminal" Section (Lines 42-50)

**Current:**
```markdown
### 🖥️ Opening Terminal on Mac

Terminal is an app on your Mac that lets you run commands.

1. Press `Command ⌘ + Space`
2. Type **Terminal**
3. Press **Enter**

You'll see a window with text and a blinking cursor - this is where you'll type commands!
```

**Change to:**
```markdown
### 🖥️ Opening Terminal

Terminal is an app that lets you type commands.

**On Mac:**
1. Press `Command ⌘ + Space`
2. Type **Terminal**
3. Press **Enter**

**On Windows:**
1. Install Git for Windows from [git-scm.com](https://git-scm.com/download/win) if you haven't already
2. Right-click on your desktop or in a folder
3. Select **"Git Bash Here"**

**On Linux:**
1. Press `Ctrl + Alt + T`
Or search for "Terminal" in your applications

You'll see a window with text and a blinking cursor - this is where you'll type commands!
```

**Rationale:** Provide instructions for all three major platforms.

### Update Terminal Commands Section (Lines 86-90)

**Current:**
```markdown
- `Command+C` - Stop something that's running
```

**Change to:**
```markdown
- `Ctrl+C` (or `Command+C` on Mac) - Stop something that's running
```

**Rationale:** Ctrl+C is standard on Windows/Linux, Command+C on Mac.

### Update "How to Open a Second Terminal" (Lines 189-192)

**Current:**
```markdown
### How to Open a Second Terminal:
1. In Terminal, press `Command ⌘ + N`
2. A new Terminal window appears
3. Click between windows to switch
```

**Change to:**
```markdown
### How to Open a Second Terminal:

**On Mac:**
1. In Terminal, press `Command ⌘ + N`

**On Windows (Git Bash):**
1. Right-click in a folder and select "Git Bash Here" again

**On Linux:**
1. Press `Ctrl + Shift + N` in most terminals
Or open a new terminal from your applications

Click between windows to switch.
```

**Rationale:** Different platforms have different methods for opening new terminal windows.

### Update Simple Alternatives in Optional Editors (Line 420)

**Current:**
```markdown
- **Mac**: TextEdit (already installed) - Just switch to "Plain Text" mode
```

**Change to:**
```markdown
- **Mac**: TextEdit (already installed) - Just switch to "Plain Text" mode
- **Windows**: Notepad (already installed) - Simple and basic
- **Linux**: Usually comes with gedit or similar
```

**Rationale:** Include default text editors for all platforms.

---

## 3. Summary of Changes

### setup.sh:
1. Remove OS check function and related code
2. Update header comment
3. Update QUICK_START.txt keyboard shortcut

### README.md:
1. Remove "Mac computer" requirement
2. Add terminal instructions for all platforms
3. Update keyboard shortcuts to include platform variations
4. Add instructions for opening multiple terminals on each platform
5. Include text editors for all platforms

These changes make the project truly cross-platform while maintaining simplicity for non-technical users.