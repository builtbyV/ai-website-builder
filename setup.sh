#!/bin/bash

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

# Function to check if a package is installed globally
check_installed() {
    if npm list -g "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to check Node.js version
check_node_version() {
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v | cut -d'v' -f2)
        REQUIRED_VERSION="18.0.0"
        if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" = "$REQUIRED_VERSION" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

# Check prerequisites
echo "Checking prerequisites..."
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed${NC}"
    echo "Please install Node.js (version 18 or higher) from https://nodejs.org"
    exit 1
elif ! check_node_version; then
    echo -e "${YELLOW}⚠️  Node.js version is below 18${NC}"
    echo "Please update Node.js from https://nodejs.org"
    exit 1
else
    echo -e "${GREEN}✅ Node.js $(node -v) detected${NC}"
fi

# Check npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm is not installed${NC}"
    echo "npm should come with Node.js. Please reinstall Node.js."
    exit 1
else
    echo -e "${GREEN}✅ npm $(npm -v) detected${NC}"
fi

echo ""
echo "Checking AI assistant installations..."
echo ""

# Check which tools are already installed
CLAUDE_INSTALLED=false
CODEX_INSTALLED=false
GEMINI_INSTALLED=false

if check_installed "@anthropic-ai/claude-code"; then
    CLAUDE_INSTALLED=true
    echo -e "${GREEN}✅ Claude Code - Already installed${NC}"
else
    echo -e "${YELLOW}❌ Claude Code - Not installed${NC}"
fi

if check_installed "@openai/codex"; then
    CODEX_INSTALLED=true
    echo -e "${GREEN}✅ OpenAI Codex CLI - Already installed${NC}"
else
    echo -e "${YELLOW}❌ OpenAI Codex CLI - Not installed${NC}"
fi

if check_installed "@google/gemini-cli"; then
    GEMINI_INSTALLED=true
    echo -e "${GREEN}✅ Gemini CLI - Already installed${NC}"
else
    echo -e "${YELLOW}❌ Gemini CLI - Not installed${NC}"
fi

# Ask which AI assistant to install
echo ""
echo "Which AI assistant would you like to use?"
echo ""

# Dynamic menu based on what's installed
if [ "$CLAUDE_INSTALLED" = false ]; then
    echo "1) Claude Code (by Anthropic)"
else
    echo "1) Claude Code (by Anthropic) ✅ Already installed"
fi

if [ "$CODEX_INSTALLED" = false ]; then
    echo "2) OpenAI Codex CLI"
else
    echo "2) OpenAI Codex CLI ✅ Already installed"
fi

if [ "$GEMINI_INSTALLED" = false ]; then
    echo "3) Gemini CLI (by Google)"
else
    echo "3) Gemini CLI (by Google) ✅ Already installed"
fi

echo "4) Install all three"
echo "5) Skip (I'll install later)"
echo ""
read -p "Enter your choice (1-5): " ai_choice

echo ""

case $ai_choice in
    1)
        if [ "$CLAUDE_INSTALLED" = true ]; then
            echo -e "${GREEN}Claude Code is already installed!${NC}"
        else
            echo "Installing Claude Code..."
            if npm install -g @anthropic-ai/claude-code; then
                echo -e "${GREEN}✅ Claude Code installed successfully${NC}"
            else
                echo -e "${RED}❌ Failed to install Claude Code${NC}"
                echo "You can try again later with: npm install -g @anthropic-ai/claude-code"
            fi
        fi
        ;;
        
    2)
        if [ "$CODEX_INSTALLED" = true ]; then
            echo -e "${GREEN}OpenAI Codex CLI is already installed!${NC}"
        else
            echo "Installing OpenAI Codex CLI..."
            if npm install -g @openai/codex; then
                echo -e "${GREEN}✅ OpenAI Codex CLI installed successfully${NC}"
            else
                echo -e "${RED}❌ Failed to install OpenAI Codex CLI${NC}"
                echo "You can try again later with: npm install -g @openai/codex"
            fi
        fi
        ;;
        
    3)
        if [ "$GEMINI_INSTALLED" = true ]; then
            echo -e "${GREEN}Gemini CLI is already installed!${NC}"
        else
            echo "Installing Gemini CLI..."
            if npm install -g @google/gemini-cli; then
                echo -e "${GREEN}✅ Gemini CLI installed successfully${NC}"
            else
                echo -e "${RED}❌ Failed to install Gemini CLI${NC}"
                echo "You can try again later with: npm install -g @google/gemini-cli"
            fi
        fi
        ;;
        
    4)
        echo "Installing all AI assistants..."
        echo ""
        
        if [ "$CLAUDE_INSTALLED" = false ]; then
            echo "Installing Claude Code..."
            if npm install -g @anthropic-ai/claude-code; then
                echo -e "${GREEN}✅ Claude Code installed successfully${NC}"
            else
                echo -e "${RED}❌ Failed to install Claude Code${NC}"
            fi
        fi
        
        if [ "$CODEX_INSTALLED" = false ]; then
            echo "Installing OpenAI Codex CLI..."
            if npm install -g @openai/codex; then
                echo -e "${GREEN}✅ OpenAI Codex CLI installed successfully${NC}"
            else
                echo -e "${RED}❌ Failed to install OpenAI Codex CLI${NC}"
            fi
        fi
        
        if [ "$GEMINI_INSTALLED" = false ]; then
            echo "Installing Gemini CLI..."
            if npm install -g @google/gemini-cli; then
                echo -e "${GREEN}✅ Gemini CLI installed successfully${NC}"
            else
                echo -e "${RED}❌ Failed to install Gemini CLI${NC}"
            fi
        fi
        ;;
        
    5)
        echo "Skipping AI assistant installation..."
        ;;
        
    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

# Check if we're in a project directory
echo ""
if [ -f "package.json" ]; then
    echo -e "${BLUE}Project detected!${NC} Installing website dependencies..."
    if npm install; then
        echo -e "${GREEN}✅ Website dependencies installed${NC}"
    else
        echo -e "${RED}❌ Failed to install website dependencies${NC}"
        echo "You can try running 'npm install' manually later."
    fi
else
    echo -e "${YELLOW}Note: No package.json found. Make sure you're in your project folder.${NC}"
fi

# Create or update .gitignore
echo ""
echo "Setting up .gitignore..."
if [ ! -f .gitignore ]; then
    cat > .gitignore << 'EOF'
# AI Assistant Documentation (not needed for live website)
AGENTS.md
GEMINI.md
setup.sh
QUICK_START.txt
EOF
    echo -e "${GREEN}✅ Created .gitignore file${NC}"
else
    # Check if our docs are already in gitignore
    if ! grep -q "AGENTS.md" .gitignore; then
        echo "" >> .gitignore
        echo "# AI Assistant Documentation (not needed for live website)" >> .gitignore
        echo "AGENTS.md" >> .gitignore
        echo "GEMINI.md" >> .gitignore
        echo "setup.sh" >> .gitignore
        echo "QUICK_START.txt" >> .gitignore
        echo -e "${GREEN}✅ Updated .gitignore file${NC}"
    else
        echo -e "${GREEN}✅ .gitignore already configured${NC}"
    fi
fi

# Final instructions
echo ""
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo ""
echo -e "${BLUE}To start building your website:${NC}"
echo "1. Make sure you're in your project folder"
echo "2. Start the preview server in one terminal:"
echo "   ${YELLOW}npm run dev${NC}"
echo ""
echo "3. In another terminal, start your AI assistant:"
echo "   ${YELLOW}npx claude${NC}    # For Claude Code"
echo "   ${YELLOW}npx codex${NC}     # For OpenAI Codex CLI" 
echo "   ${YELLOW}npx gemini${NC}    # For Gemini CLI"
echo ""
echo -e "${BLUE}To create another website:${NC}"
echo "   cd .."
echo "   git clone https://github.com/builtbyV/ai-website-builder.git my-new-site"
echo "   cd my-new-site"
echo "   bash setup.sh"
echo ""
echo -e "${GREEN}Using 'npx' ensures commands always work - no PATH setup needed!${NC}"
echo ""
echo "Happy building! 🚀"

# Create a quick reference file
echo ""
read -p "Would you like to create a QUICK_START.txt file for reference? (y/n): " create_ref

if [[ $create_ref =~ ^[Yy]$ ]]; then
    cat > QUICK_START.txt << 'EOF'
AI WEBSITE BUILDER - QUICK START REFERENCE
==========================================

STARTING YOUR WEBSITE:
1. Open two terminal windows
2. Terminal 1: npm run dev (preview server)
3. Terminal 2: npx claude (or npx codex or npx gemini)

AI COMMANDS:
- npx claude   # Claude Code by Anthropic
- npx codex    # OpenAI Codex CLI  
- npx gemini   # Gemini CLI by Google

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
    echo -e "${GREEN}✅ Created QUICK_START.txt for your reference${NC}"
fi
