#!/bin/bash

# AI Website Builder - Setup & Installation Script
# This script installs AI coding assistants (Claude Code & OpenAI Codex CLI)
# and prepares your project for development and deployment
# Version: 1.0.0
# Supports: macOS only (for now)

set -e  # Exit on error

# Color codes for better UX
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Spinner function for loading animations
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Print formatted messages
print_header() {
    echo -e "\n${PURPLE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}  ${BOLD}$1${NC}"
    echo -e "${PURPLE}╚═══════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if running on macOS
check_os() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This installer only supports macOS. Detected OS: $OSTYPE"
        exit 1
    fi
    print_success "macOS detected"
}

# Check if we're in the right directory
check_project_directory() {
    print_header "Checking Project Directory"
    
    if [[ ! -f "package.json" ]] || [[ ! -f "CLAUDE.md" ]]; then
        print_warning "This doesn't look like the AI Website Builder project directory"
        echo -e "${CYAN}Expected files: package.json, CLAUDE.md, index.html${NC}"
        echo -e "${YELLOW}Are you in the right directory? (y/n)${NC} "
        read -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Please run this script from the AI Website Builder project directory"
            echo -e "${CYAN}Example:${NC}"
            echo -e "  cd ~/path/to/ai-website-builder"
            echo -e "  bash setup.sh"
            exit 1
        fi
    else
        print_success "AI Website Builder project detected"
    fi
}

# Check for required dependencies
check_dependencies() {
    print_header "Checking System Dependencies"
    
    local missing_deps=()
    
    # Check for Homebrew
    if ! command -v brew &> /dev/null; then
        missing_deps+=("Homebrew")
    else
        print_success "Homebrew installed"
    fi
    
    # Check for Node.js
    if ! command -v node &> /dev/null; then
        missing_deps+=("Node.js")
    else
        NODE_VERSION=$(node -v | cut -d'v' -f2)
        MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'.' -f1)
        if [ "$MAJOR_VERSION" -lt 18 ]; then
            print_error "Node.js version $NODE_VERSION is too old. Version 18+ required."
            missing_deps+=("Node.js 18+")
        else
            print_success "Node.js $NODE_VERSION installed"
        fi
    fi
    
    # Check for npm
    if ! command -v npm &> /dev/null; then
        missing_deps+=("npm")
    else
        print_success "npm $(npm -v) installed"
    fi
    
    # Check for Git
    if ! command -v git &> /dev/null; then
        missing_deps+=("Git")
    else
        print_success "Git $(git --version | awk '{print $3}') installed"
    fi
    
    # If there are missing dependencies, offer to install them
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo ""
        print_warning "Missing dependencies: ${missing_deps[*]}"
        echo -e "\n${CYAN}Would you like to install missing dependencies? (y/n)${NC} "
        read -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_dependencies "${missing_deps[@]}"
        else
            print_error "Cannot proceed without required dependencies."
            exit 1
        fi
    fi
}

# Install missing dependencies
install_dependencies() {
    local deps=("$@")
    
    # Install Homebrew if missing
    if [[ " ${deps[@]} " =~ " Homebrew " ]]; then
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        print_success "Homebrew installed"
    fi
    
    # Install Node.js if missing or outdated
    if [[ " ${deps[@]} " =~ " Node.js " ]] || [[ " ${deps[@]} " =~ " Node.js 18+ " ]] || [[ " ${deps[@]} " =~ " npm " ]]; then
        print_info "Installing Node.js 18+..."
        brew install node@18
        brew link --overwrite node@18
        print_success "Node.js 18+ and npm installed"
    fi
    
    # Install Git if missing
    if [[ " ${deps[@]} " =~ " Git " ]]; then
        print_info "Installing Git..."
        brew install git
        print_success "Git installed"
    fi
}

# Configure npm to avoid permission issues
configure_npm() {
    print_header "Configuring npm"
    
    # Check if npm global prefix is already configured
    NPM_PREFIX=$(npm config get prefix 2>/dev/null || echo "")
    
    if [[ "$NPM_PREFIX" == "/usr/local" ]] || [[ "$NPM_PREFIX" == "/usr" ]]; then
        print_warning "npm global prefix is set to a system directory. Configuring user directory..."
        
        mkdir -p ~/.npm-global
        npm config set prefix ~/.npm-global
        
        # Add to PATH in appropriate shell config
        SHELL_CONFIG=""
        if [[ -f ~/.zshrc ]]; then
            SHELL_CONFIG=~/.zshrc
        elif [[ -f ~/.bash_profile ]]; then
            SHELL_CONFIG=~/.bash_profile
        else
            SHELL_CONFIG=~/.profile
        fi
        
        if ! grep -q "export PATH=~/.npm-global/bin:\$PATH" "$SHELL_CONFIG"; then
            echo 'export PATH=~/.npm-global/bin:$PATH' >> "$SHELL_CONFIG"
            print_info "Added npm global bin to PATH in $SHELL_CONFIG"
            print_warning "Please run: source $SHELL_CONFIG"
        fi
        
        export PATH=~/.npm-global/bin:$PATH
    fi
    
    print_success "npm configured correctly"
}

# Install project dependencies
install_project_dependencies() {
    print_header "Installing Project Dependencies"
    
    if [[ -f "package.json" ]]; then
        print_info "Installing AI Website Builder dependencies..."
        npm install &
        spinner $!
        print_success "Project dependencies installed"
    else
        print_error "No package.json found - cannot install project dependencies"
        exit 1
    fi
}

# Install Claude Code
install_claude_code() {
    print_header "Installing Claude Code"
    
    echo -e "${CYAN}Claude Code is an AI coding assistant by Anthropic that lives in your terminal.${NC}"
    echo -e "${CYAN}It understands your project and helps you build through natural conversation.${NC}\n"
    
    echo -e "${BOLD}Would you like to install Claude Code? (y/n)${NC} "
    read -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Skipping Claude Code installation"
        return
    fi
    
    print_info "Installing Claude Code..."
    
    # Install Claude Code
    npm install -g @anthropic-ai/claude-code &
    spinner $!
    
    if command -v claude &> /dev/null; then
        print_success "Claude Code installed successfully!"
        
        echo -e "\n${CYAN}To start Claude Code:${NC}"
        echo -e "  1. Navigate to your project: ${GREEN}cd $(pwd)${NC}"
        echo -e "  2. Run: ${GREEN}claude${NC}"
        echo -e "  3. Follow the authentication prompts in your browser\n"
        
        echo -e "${CYAN}📚 Quick Start Guide: https://docs.anthropic.com/en/docs/claude-code/quickstart${NC}\n"
    else
        print_error "Claude Code installation failed"
        print_info "Try running manually: npm install -g @anthropic-ai/claude-code"
    fi
}

# Install OpenAI Codex CLI
install_codex_cli() {
    print_header "Installing OpenAI Codex CLI"
    
    echo -e "${CYAN}OpenAI Codex CLI is an AI coding agent by OpenAI that brings${NC}"
    echo -e "${CYAN}powerful reasoning models directly to your terminal.${NC}\n"
    
    echo -e "${BOLD}Would you like to install OpenAI Codex CLI? (y/n)${NC} "
    read -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Skipping OpenAI Codex CLI installation"
        return
    fi
    
    print_info "Installing OpenAI Codex CLI..."
    
    # Install Codex CLI
    npm install -g @openai/codex &
    spinner $!
    
    if command -v codex &> /dev/null; then
        print_success "OpenAI Codex CLI installed successfully!"
        
        echo -e "\n${CYAN}To start Codex CLI:${NC}"
        echo -e "  1. Navigate to your project: ${GREEN}cd $(pwd)${NC}"
        echo -e "  2. Run: ${GREEN}codex${NC}"
        echo -e "  3. Follow the setup prompts\n"
        
        echo -e "${CYAN}📚 Getting Started: https://help.openai.com/en/articles/11096431-openai-codex-cli-getting-started${NC}\n"
    else
        print_error "OpenAI Codex CLI installation failed"
        print_info "Try running manually: npm install -g @openai/codex"
    fi
}

# Show test commands
show_test_commands() {
    print_header "Testing Your Setup"
    
    echo -e "${CYAN}Let's make sure everything works:${NC}\n"
    
    echo -e "${BOLD}1. Test your website:${NC}"
    echo -e "   Open a new terminal and run:"
    echo -e "   ${GREEN}npm run dev${NC}"
    echo -e "   Then open http://localhost:5173 in your browser\n"
    
    if command -v claude &> /dev/null; then
        echo -e "${BOLD}2. Test Claude Code:${NC}"
        echo -e "   In another terminal, run:"
        echo -e "   ${GREEN}claude${NC}"
        echo -e "   Try: 'summarize this project'\n"
    fi
    
    if command -v codex &> /dev/null; then
        echo -e "${BOLD}3. Test Codex CLI:${NC}"
        echo -e "   First: ${GREEN}export OPENAI_API_KEY='your-key'${NC}"
        echo -e "   Then: ${GREEN}codex${NC}\n"
    fi
    
    echo -e "${YELLOW}Tip: Keep Terminal 1 running npm run dev, use Terminal 2 for AI${NC}\n"
}

# Main installation flow
main() {
    clear
    
    echo -e "${BOLD}${PURPLE}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║        🚀 AI Website Builder - Setup & Installation 🚀     ║"
    echo "║                                                           ║"
    echo "║    Installing AI assistants for your website project      ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Check OS
    check_os
    
    # Check project directory
    check_project_directory
    
    # Check and install dependencies
    check_dependencies
    
    # Configure npm
    configure_npm
    
    # Install project dependencies
    install_project_dependencies
    
    # Install AI tools
    install_claude_code
    install_codex_cli
    
    # Final summary
    print_header "Installation Complete! 🎉"
    
    echo -e "${GREEN}AI Website Builder is ready to use!${NC}\n"
    
    # Check what was installed
    if command -v claude &> /dev/null; then
        echo -e "${GREEN}✓ Claude Code${NC} - Ready to use"
    fi
    
    if command -v codex &> /dev/null; then
        echo -e "${GREEN}✓ OpenAI Codex CLI${NC} - Ready to use"
    fi
    
    echo -e "${GREEN}✓ Project dependencies${NC} - Installed"
    
    # Show test commands
    show_test_commands
    
    echo -e "${YELLOW}Remember to reload your shell configuration:${NC}"
    if [[ -f ~/.zshrc ]]; then
        echo -e "  ${GREEN}source ~/.zshrc${NC}"
    elif [[ -f ~/.bash_profile ]]; then
        echo -e "  ${GREEN}source ~/.bash_profile${NC}"
    else
        echo -e "  ${GREEN}source ~/.profile${NC}"
    fi
    
    echo -e "\n${CYAN}Happy building! 🚀${NC}\n"
}

# Run main function
main
