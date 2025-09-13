#!/bin/bash

# This script installs AI coding assistants (Claude Code & Gemini CLI & OpenAI Codex CLI)
# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ASCII symbols for visual feedback - works on all platforms
CHECK="${GREEN}[✓]${NC}"
WORKING="${BLUE}[...]${NC}"
WARN="${YELLOW}[!]${NC}"
ERROR="${RED}[X]${NC}"
PARTY="*"
BOLD='\033[1m'

# Function to show progress
show_progress() {
    echo -e "${WORKING} $1..."
}

# Function to show completion
show_done() {
    echo -e "${CHECK} $1"
}

# Function to show error with helpful message
show_error() {
    echo -e "${ERROR} $1"
    echo -e "${YELLOW}Tip: $2${NC}"
}

# Clear screen for fresh start
clear

# Welcome banner
echo -e "${BLUE}${BOLD}"
echo "================================================="
echo "                                                 "
echo "     AI Website Builder - Easy Setup! *          "
echo "                                                 "
echo "     Build websites by chatting with AI!         "
echo "                                                 "
echo "================================================="
echo -e "${NC}"
echo ""
echo -e "${GREEN}Welcome! This setup will take about 2-3 minutes.${NC}"
echo -e "${YELLOW}Don't worry - you can't break anything!${NC}"
echo ""
echo "Press Enter to continue..."
read

# Function to check if a package is installed globally
check_installed() {
    if npm list -g "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to update all installation status
update_installation_status() {
    CLAUDE_INSTALLED=false
    CODEX_INSTALLED=false
    GEMINI_INSTALLED=false
    
    check_installed "@anthropic-ai/claude-code" && CLAUDE_INSTALLED=true
    check_installed "@openai/codex" && CODEX_INSTALLED=true
    check_installed "@google/gemini-cli" && GEMINI_INSTALLED=true
}

# Function to check Node.js version
check_node_version() {
    if command -v node >/dev/null 2>&1; then
        REQUIRED_VERSION="18.0.0"
        node -e "process.exit(process.versions.node.localeCompare('$REQUIRED_VERSION', undefined, {numeric:true, sensitivity:'base'}) >= 0 ? 0 : 1)"
        return $?
    else
        return 1
    fi
}

# Enhanced installation function for AI tools
install_ai_tool() {
    local tool_name=$1
    local package_name=$2
    
    # Check if already installed
    if check_installed "$package_name"; then
        show_done "$tool_name is already installed"
        return 0
    fi
    
    show_progress "Installing $tool_name"
    
    # Progress indicator
    (
        while true; do
            echo -n "."
            sleep 1
        done
    ) &
    local PROGRESS_PID=$!
    
    if npm install -g "$package_name" > "/tmp/${tool_name// /-}-install.log" 2>&1; then
        kill $PROGRESS_PID 2>/dev/null
        echo ""
        show_done "$tool_name installed successfully!"
        return 0
    else
        kill $PROGRESS_PID 2>/dev/null
        echo ""
        show_error "Failed to install $tool_name" "You can try again later with: npm install -g $package_name"
        return 1
    fi
}

# Check prerequisites
echo ""
echo -e "${BLUE}${BOLD}Step 1: Checking Prerequisites${NC}"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    show_error "Node.js is not installed" "Please visit https://nodejs.org to download and install it"
    exit 1
elif ! check_node_version; then
    show_error "Please update Node.js to version 18 or higher" "Download from https://nodejs.org"
    exit 1
else
    show_done "Node.js $(node -v) detected"
fi

# Check npm
if ! command -v npm &> /dev/null; then
    show_error "npm is not installed" "npm should come with Node.js. Please reinstall Node.js"
    exit 1
else
    show_done "npm $(npm -v) detected"
fi

echo ""
echo -e "${BLUE}${BOLD}Step 2: Checking Installed AI Assistants${NC}"
echo ""

# Check which tools are already installed
update_installation_status

if [ "$CLAUDE_INSTALLED" = true ]; then
    show_done "Claude Code - Already installed"
else
    echo -e "${YELLOW}○${NC} Claude Code - Not installed"
fi

if [ "$CODEX_INSTALLED" = true ]; then
    show_done "OpenAI Codex CLI - Already installed"
else
    echo -e "${YELLOW}○${NC} OpenAI Codex CLI - Not installed"
fi

if [ "$GEMINI_INSTALLED" = true ]; then
    show_done "Gemini CLI - Already installed"
else
    echo -e "${YELLOW}○${NC} Gemini CLI - Not installed"
fi

echo ""

# Always show Step 3 for consistency
echo ""
echo -e "${BLUE}${BOLD}Step 3: Choose Your AI Assistant${NC}"
echo ""

# Check if all tools are already installed
if [ "$CLAUDE_INSTALLED" = true ] && [ "$CODEX_INSTALLED" = true ] && [ "$GEMINI_INSTALLED" = true ]; then
    echo -e "${GREEN}${BOLD}✓ All AI assistants are already installed!${NC}"
    echo ""
    echo "You can start using:"
    echo -e "   ${YELLOW}npx claude${NC}   # For Claude Code"
    echo -e "   ${YELLOW}npx codex${NC}    # For OpenAI Codex"
    echo -e "   ${YELLOW}npx gemini${NC}   # For Google Gemini"
    echo ""
else
    # Only show menu if not all tools are installed
    if [ "$CLAUDE_INSTALLED" = false ] || [ "$CODEX_INSTALLED" = false ] || [ "$GEMINI_INSTALLED" = false ]; then
        echo "Which AI assistant would you like to install?"
        echo ""
        
        # Build dynamic menu
        MENU_OPTIONS=()
        MENU_MAPPING=()
        OPTION_NUM=1
        
        # Add Gemini if not installed
        if [ "$GEMINI_INSTALLED" = false ]; then
            echo -e "${BOLD}$OPTION_NUM) ${YELLOW}Google Gemini${NC}"
            echo "   • Sign in with your Google account"
            echo "   • Free tier: 60 requests/min and 1,000 requests/day"
            echo ""
            MENU_OPTIONS+=("$OPTION_NUM")
            MENU_MAPPING+=("gemini")
            ((OPTION_NUM++))
        fi
        
        # Add Claude if not installed
        if [ "$CLAUDE_INSTALLED" = false ]; then
            echo -e "${BOLD}$OPTION_NUM) ${GREEN}Claude Code${NC}"
            echo "   • Sign in with your Claude.ai account (subscription plan) or use API key"
            echo "   • Subscription: Claude.ai plans (e.g., Pro)"
            echo ""
            MENU_OPTIONS+=("$OPTION_NUM")
            MENU_MAPPING+=("claude")
            ((OPTION_NUM++))
        fi
        
        # Add Codex if not installed
        if [ "$CODEX_INSTALLED" = false ]; then
            echo -e "${BOLD}$OPTION_NUM) ${BLUE}OpenAI Codex${NC}"
            echo "   • Use OpenAI Plus/Pro subscription OR API key"
            echo "   • API: Pay-as-you-go with free credits for new users"
            echo "   • Subscription: Included in OpenAI Plus"
            echo ""
            MENU_OPTIONS+=("$OPTION_NUM")
            MENU_MAPPING+=("codex")
            ((OPTION_NUM++))
        fi
        
        # Add "Install all remaining" option if more than one is not installed
        TOOLS_NOT_INSTALLED=0
        [ "$GEMINI_INSTALLED" = false ] && ((TOOLS_NOT_INSTALLED++))
        [ "$CLAUDE_INSTALLED" = false ] && ((TOOLS_NOT_INSTALLED++))
        [ "$CODEX_INSTALLED" = false ] && ((TOOLS_NOT_INSTALLED++))
        
        if [ $TOOLS_NOT_INSTALLED -gt 1 ]; then
            echo -e "${BOLD}$OPTION_NUM) Install all remaining tools${NC}"
            echo ""
            MENU_OPTIONS+=("$OPTION_NUM")
            MENU_MAPPING+=("all")
            ((OPTION_NUM++))
        fi
        
        # Always add skip option
        echo -e "${BOLD}$OPTION_NUM) Skip for now${NC}"
        echo ""
        MENU_OPTIONS+=("$OPTION_NUM")
        MENU_MAPPING+=("skip")
        ((OPTION_NUM++))
        
        # Get user choice with validation
        while true; do
            echo -n "Enter your choice (1-$((OPTION_NUM-1))): "
            read -r choice
            
            # Check if choice is valid
            if [[ " ${MENU_OPTIONS[@]} " =~ " ${choice} " ]]; then
                break
            else
                echo -e "${RED}Please enter a number between 1 and $((OPTION_NUM-1))${NC}"
            fi
        done
        
        # Map choice to action
        ACTION_INDEX=$((choice - 1))
        ACTION="${MENU_MAPPING[$ACTION_INDEX]}"
        
        # Execute based on mapped action
        case $ACTION in
            "gemini")
                install_ai_tool "Gemini CLI" "@google/gemini-cli" && GEMINI_INSTALLED=true
                ;;
            "claude")
                install_ai_tool "Claude Code" "@anthropic-ai/claude-code" && CLAUDE_INSTALLED=true
                ;;
            "codex")
                install_ai_tool "OpenAI Codex CLI" "@openai/codex" && CODEX_INSTALLED=true
                ;;
            "all")
                echo ""
                echo -e "${BLUE}Installing all remaining AI assistants...${NC}"
                echo ""
                [ "$GEMINI_INSTALLED" = false ] && install_ai_tool "Gemini CLI" "@google/gemini-cli" && GEMINI_INSTALLED=true
                [ "$CLAUDE_INSTALLED" = false ] && install_ai_tool "Claude Code" "@anthropic-ai/claude-code" && CLAUDE_INSTALLED=true
                [ "$CODEX_INSTALLED" = false ] && install_ai_tool "OpenAI Codex CLI" "@openai/codex" && CODEX_INSTALLED=true
                ;;
            "skip")
                echo ""
                echo -e "${YELLOW}Skipping AI assistant installation${NC}"
                ;;
        esac
    fi
fi

# Final status check
echo ""
update_installation_status  # Re-check after installations

if [ "$CLAUDE_INSTALLED" = true ] && [ "$CODEX_INSTALLED" = true ] && [ "$GEMINI_INSTALLED" = true ]; then
    echo -e "${GREEN}${BOLD}All AI assistants are installed and ready!${NC}"
elif [ "$CLAUDE_INSTALLED" = true ] || [ "$CODEX_INSTALLED" = true ] || [ "$GEMINI_INSTALLED" = true ]; then
    echo -e "${BLUE}${BOLD}Installed AI assistants:${NC}"
    [ "$CLAUDE_INSTALLED" = true ] && echo -e "   ${GREEN}✓${NC} Claude Code"
    [ "$CODEX_INSTALLED" = true ] && echo -e "   ${GREEN}✓${NC} OpenAI Codex"
    [ "$GEMINI_INSTALLED" = true ] && echo -e "   ${GREEN}✓${NC} Google Gemini"
else
    echo -e "${YELLOW}No AI assistants installed yet.${NC}"
    echo "You can run setup.sh again later to install them."
fi
echo ""

echo ""
echo -e "${BLUE}${BOLD}Step 4: Installing Website Dependencies${NC}"
echo ""

# Check if we're in a project directory
if [ -f "package.json" ]; then
    show_progress "Installing website building blocks"
    
    # Create a simple progress indicator
    (
        while true; do
            echo -n "."
            sleep 1
        done
    ) &
    PROGRESS_PID=$!
    
    # Run npm install
    if npm install > /tmp/npm-install.log 2>&1; then
        kill $PROGRESS_PID 2>/dev/null
        echo "" # New line after dots
        show_done "All components installed successfully!"
        
        # Show package count for satisfaction
        PACKAGE_COUNT=$(npm list --depth=0 2>/dev/null | grep -c "├\|└")
        echo -e "   ${GREEN}Added $PACKAGE_COUNT packages${NC}"
    else
        kill $PROGRESS_PID 2>/dev/null
        echo ""
        show_error "Some components failed to install" "Try running 'npm install' manually"
        echo "Check /tmp/npm-install.log for details"
    fi
else
    echo -e "${YELLOW}Note: Make sure you're in the ai-website-builder folder.${NC}"
    echo "You should see files like index.html and package.json"
fi

echo ""
echo -e "${BLUE}${BOLD}Step 5: Setting Up Project Files${NC}"
echo ""

# Create .gitignore silently
if [ ! -f .gitignore ]; then
    cat > .gitignore << 'EOF'
# AI Assistant Documentation (not needed for live website)
AGENTS.md
CLAUDE.md
GEMINI.md
setup.sh
QUICK_REFERENCE.txt
setup-guide.html
scripts/
docs/
EOF
    show_done "Created .gitignore file"
else
    # Update if needed
    if ! grep -q "# AI Assistant Documentation" .gitignore; then
        echo "" >> .gitignore
        echo "# AI Assistant Documentation (not needed for live website)" >> .gitignore
        echo "AGENTS.md" >> .gitignore
        echo "CLAUDE.md" >> .gitignore
        echo "GEMINI.md" >> .gitignore
        echo "setup.sh" >> .gitignore
        echo "QUICK_REFERENCE.txt" >> .gitignore
        echo "setup-guide.html" >> .gitignore
        echo "scripts/" >> .gitignore
        echo "docs/" >> .gitignore
        show_done "Updated .gitignore file"
    fi
fi

# Create simple README with project name
PROJECT_NAME=$(basename "$(pwd)")
if [ -f "README.md" ]; then
    echo "# $PROJECT_NAME" > README.md
    show_done "Updated README.md"
else
    echo "# $PROJECT_NAME" > README.md
    show_done "Created README.md"
fi

# Remove template git
rm -rf .git 2>/dev/null

# Create a quick reference file
echo ""
read -p "Would you like to create a QUICK_REFERENCE.txt file for reference? (y/n): " create_ref

if [[ $create_ref =~ ^[Yy]$ ]]; then
    # Start creating the file
    cat > QUICK_REFERENCE.txt << 'EOF'
AI WEBSITE BUILDER - QUICK REFERENCE
====================================

STARTING YOUR WEBSITE:
1. Open two terminal windows
2. Terminal 1: npm run dev (preview server)
3. Terminal 2: Start your AI assistant (see below)

AI COMMANDS:
EOF

    # Add only installed tools
    [ "$CLAUDE_INSTALLED" = true ] && echo "- npx claude   # Claude Code by Anthropic" >> QUICK_REFERENCE.txt
    [ "$CODEX_INSTALLED" = true ] && echo "- npx codex    # OpenAI Codex CLI" >> QUICK_REFERENCE.txt
    [ "$GEMINI_INSTALLED" = true ] && echo "- npx gemini   # Gemini CLI by Google" >> QUICK_REFERENCE.txt
    
    # If none installed
    if [ "$CLAUDE_INSTALLED" = false ] && [ "$CODEX_INSTALLED" = false ] && [ "$GEMINI_INSTALLED" = false ]; then
        echo "- No AI assistants installed yet. Run setup.sh to install one." >> QUICK_REFERENCE.txt
    fi

    # Continue with rest of content
    cat >> QUICK_REFERENCE.txt << 'EOF'

HELPFUL TERMINAL COMMANDS:
- cd folder-name   # Go into a folder
- cd ..           # Go back up one folder
- ls              # See files (Mac/Linux)
- dir             # See files (Windows)
- pwd             # See where you are
- Ctrl+C (or Command+C on Mac)  # Stop something running

COMMON REQUESTS TO YOUR AI:
- "Help me understand this project"
- "Change the business name to [Your Business]"
- "Make the colors match my brand"
- "Add photos from my images folder"
- "I want to publish my website"

PUBLISHING YOUR WEBSITE:
Just tell your AI: "I want to publish my website"
They'll handle everything!

CREATE ANOTHER WEBSITE:
cd ..
git clone https://github.com/builtbyV/ai-website-builder.git another-site
cd another-site
bash setup.sh

NEED HELP?
Just ask your AI assistant - they're here to help!
EOF
    show_done "Created QUICK_REFERENCE.txt for your reference"
fi

# Make scripts executable if present
if [ -d "scripts" ]; then
    chmod +x scripts/*.sh 2>/dev/null || true
    chmod +x scripts/*.mjs 2>/dev/null || true
    show_done "Marked scripts as executable"
fi

# Final success message
echo ""
echo -e "${GREEN}${BOLD}===================================================${NC}"
echo -e "${GREEN}${BOLD}     * Setup Complete! You're ready to build! *     ${NC}"
echo -e "${GREEN}${BOLD}===================================================${NC}"
echo ""
echo -e "${BLUE}${BOLD}What's Next?${NC}"
echo ""
echo "1. Open the visual guide:"
echo -e "   ${YELLOW}Open setup-guide.html in your web browser${NC}"
echo ""
echo "2. Start your website preview:"
echo -e "   ${YELLOW}npm run dev${NC}"
echo ""
echo "3. In a new terminal, chat with your AI:"

# Show specific commands based on what was installed
if [ "$GEMINI_INSTALLED" = true ]; then
    echo -e "   ${YELLOW}npx gemini${NC}  # Sign in with your Google account"
fi
if [ "$CLAUDE_INSTALLED" = true ]; then
    echo -e "   ${YELLOW}npx claude${NC}  # Use subscription or set ANTHROPIC_AUTH_TOKEN"
fi
if [ "$CODEX_INSTALLED" = true ]; then
    echo -e "   ${YELLOW}npx codex${NC}   # Login with 'codex login' or set OPENAI_API_KEY"
fi

echo ""
echo -e "${GREEN}Need help? Check QUICK_REFERENCE.txt for commands!${NC}"
echo ""
echo -e "${BLUE}Happy building! *${NC}"

# Optional guide opening
if [ -f "setup-guide.html" ]; then
    echo ""
    read -p "Would you like to open the visual guide in your browser? (y/n): " open_guide
    if [[ $open_guide =~ ^[Yy]$ ]]; then
        show_progress "Opening the visual guide in your browser"
        
        # Cross-platform browser opening
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open setup-guide.html 2>/dev/null &
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open setup-guide.html 2>/dev/null &
        elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
            start setup-guide.html 2>/dev/null &
        fi
        
        sleep 1
        show_done "Guide opened in your default browser"
    fi
fi
