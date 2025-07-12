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
    echo -e "${YELLOW}⚠️  Please update Node.js to version 18 or higher${NC}"
    echo "Download from: https://nodejs.org"
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
update_installation_status

if [ "$CLAUDE_INSTALLED" = true ]; then
    echo -e "${GREEN}✅ Claude Code - Already installed${NC}"
else
    echo -e "${YELLOW}❌ Claude Code - Not installed${NC}"
fi

if [ "$CODEX_INSTALLED" = true ]; then
    echo -e "${GREEN}✅ OpenAI Codex CLI - Already installed${NC}"
else
    echo -e "${YELLOW}❌ OpenAI Codex CLI - Not installed${NC}"
fi

if [ "$GEMINI_INSTALLED" = true ]; then
    echo -e "${GREEN}✅ Gemini CLI - Already installed${NC}"
else
    echo -e "${YELLOW}❌ Gemini CLI - Not installed${NC}"
fi

echo ""

# Claude Code
if [ "$CLAUDE_INSTALLED" = false ]; then
    read -p "Install Claude Code (by Anthropic)? (y/n): " install_claude
    if [[ $install_claude =~ ^[Yy]$ ]]; then
        echo "Installing Claude Code..."
        if npm install -g @anthropic-ai/claude-code; then
            echo -e "${GREEN}✅ Claude Code installed successfully${NC}"
            CLAUDE_INSTALLED=true
        else
            echo -e "${RED}❌ Failed to install Claude Code${NC}"
            echo "You can try again later with: npm install -g @anthropic-ai/claude-code"
        fi
    fi
    echo ""
fi

# OpenAI Codex CLI
if [ "$CODEX_INSTALLED" = false ]; then
    read -p "Install OpenAI Codex CLI? (y/n): " install_codex
    if [[ $install_codex =~ ^[Yy]$ ]]; then
        echo "Installing OpenAI Codex CLI..."
        if npm install -g @openai/codex; then
            echo -e "${GREEN}✅ OpenAI Codex CLI installed successfully${NC}"
            CODEX_INSTALLED=true
        else
            echo -e "${RED}❌ Failed to install OpenAI Codex CLI${NC}"
            echo "You can try again later with: npm install -g @openai/codex"
        fi
    fi
    echo ""
fi

# Gemini CLI
if [ "$GEMINI_INSTALLED" = false ]; then
    read -p "Install Gemini CLI (by Google)? (y/n): " install_gemini
    if [[ $install_gemini =~ ^[Yy]$ ]]; then
        echo "Installing Gemini CLI..."
        if npm install -g @google/gemini-cli; then
            echo -e "${GREEN}✅ Gemini CLI installed successfully${NC}"
            GEMINI_INSTALLED=true
        else
            echo -e "${RED}❌ Failed to install Gemini CLI${NC}"
            echo "You can try again later with: npm install -g @google/gemini-cli"
        fi
    fi
    echo ""
fi

# Check if all are now installed after any installation attempts
if [ "$CLAUDE_INSTALLED" = true ] && [ "$CODEX_INSTALLED" = true ] && [ "$GEMINI_INSTALLED" = true ]; then
    echo -e "${GREEN}✅ All AI assistants are now installed!${NC}"
    echo ""
fi

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
    echo -e "${YELLOW}Note: Make sure you're in the ai-website-builder folder.${NC}"
    echo "You should see files like index.html and package.json"
fi

# Create .gitignore silently
if [ ! -f .gitignore ]; then
    cat > .gitignore << 'EOF'
# AI Assistant Documentation (not needed for live website)
AGENTS.md
CLAUDE.md
GEMINI.md
setup.sh
QUICK_START.txt
EOF
else
    # Update if needed
    if ! grep -q "# AI Assistant Documentation" .gitignore; then
        echo "" >> .gitignore
        echo "# AI Assistant Documentation (not needed for live website)" >> .gitignore
        echo "AGENTS.md" >> .gitignore
        echo "CLAUDE.md" >> .gitignore
        echo "GEMINI.md" >> .gitignore
        echo "setup.sh" >> .gitignore
        echo "QUICK_START.txt" >> .gitignore
    fi
fi

# Create simple README with project name
PROJECT_NAME=$(basename "$(pwd)")
if [ -f "README.md" ]; then
    echo "# $PROJECT_NAME" > README.md
fi

# Remove template git
rm -rf .git 2>/dev/null

# Create GitHub Actions workflow for deployment
echo "Setting up GitHub Actions deployment..."
if mkdir -p .github/workflows; then
    cat > .github/workflows/deploy.yml << 'EOF'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 20
          
      - name: Install dependencies
        run: npm ci
        
      - name: Build
        run: npm run build
        
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF
else
    echo -e "${YELLOW}Warning: Could not create .github/workflows directory${NC}"
    echo "GitHub Actions deployment setup skipped."
fi



# Final instructions
echo ""
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo ""
echo -e "${BLUE}To start building your website:${NC}"
echo "1. Make sure you're in your project folder"
echo "2. Start the preview server in one terminal:"
echo -e "   ${YELLOW}npm run dev${NC}"
echo ""

# Only show instructions for installed tools
if [ "$CLAUDE_INSTALLED" = true ] || [ "$CODEX_INSTALLED" = true ] || [ "$GEMINI_INSTALLED" = true ]; then
    echo "3. In another terminal, start your AI assistant:"
    [ "$CLAUDE_INSTALLED" = true ] && echo -e "   ${YELLOW}npx claude${NC}    # For Claude Code"
    [ "$CODEX_INSTALLED" = true ] && echo -e "   ${YELLOW}npx codex${NC}     # For OpenAI Codex CLI"
    [ "$GEMINI_INSTALLED" = true ] && echo -e "   ${YELLOW}npx gemini${NC}    # For Gemini CLI"
else
    echo -e "${YELLOW}Note: No AI assistants installed yet.${NC}"
    echo "Run setup.sh again to install Claude Code, OpenAI Codex, or Gemini CLI."
fi

echo ""
echo -e "${BLUE}Ready to go live?${NC}"
echo "Just tell your AI assistant: 'I want to publish my website'"
echo "They'll guide you through the entire process!"
echo ""
echo -e "${BLUE}To create another website:${NC}"
echo "   cd .."
echo "   git clone https://github.com/builtbyV/ai-website-builder.git my-new-site"
echo "   cd my-new-site"
echo "   bash setup.sh"
echo ""
# Create a quick reference file
echo ""
read -p "Would you like to create a QUICK_START.txt file for reference? (y/n): " create_ref

if [[ $create_ref =~ ^[Yy]$ ]]; then
    # Start creating the file
    cat > QUICK_START.txt << 'EOF'
AI WEBSITE BUILDER - QUICK START REFERENCE
==========================================

STARTING YOUR WEBSITE:
1. Open two terminal windows
2. Terminal 1: npm run dev (preview server)
3. Terminal 2: Start your AI assistant (see below)

AI COMMANDS:
EOF

    # Add only installed tools
    [ "$CLAUDE_INSTALLED" = true ] && echo "- npx claude   # Claude Code by Anthropic" >> QUICK_START.txt
    [ "$CODEX_INSTALLED" = true ] && echo "- npx codex    # OpenAI Codex CLI" >> QUICK_START.txt
    [ "$GEMINI_INSTALLED" = true ] && echo "- npx gemini   # Gemini CLI by Google" >> QUICK_START.txt
    
    # If none installed
    if [ "$CLAUDE_INSTALLED" = false ] && [ "$CODEX_INSTALLED" = false ] && [ "$GEMINI_INSTALLED" = false ]; then
        echo "- No AI assistants installed yet. Run setup.sh to install one." >> QUICK_START.txt
    fi

    # Continue with rest of content
    cat >> QUICK_START.txt << 'EOF'

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
    echo -e "${GREEN}✅ Created QUICK_START.txt for your reference${NC}"
fi

echo ""
echo "Happy building! 🚀"
