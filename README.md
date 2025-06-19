# AI Website Builder 🤖

Build your website by just talking to AI - no coding required!

## 🎯 What is this?

This is a website template that lets you build and update your site by having conversations with AI assistants. Just describe what you want in plain English, and watch your website come to life!

### Choose Your AI Assistant:
- **Claude Code** - AI coding agent by Anthropic
- **OpenAI Codex CLI** - AI coding agent by OpenAI

Both understand natural language and can build your website - pick either one!

### Perfect for:
- Small business owners who need a professional website
- Freelancers building their portfolio
- Anyone who wants a website without learning to code
- People who think in ideas, not in HTML

## ✨ What Can You Build?

Just tell your AI assistant what you want:
- "I need a website for my coffee shop"
- "Add photos of our menu items"
- "Make it easy for people to find our location"
- "I want customers to book tables online"
- "Make it look warm and inviting"

Your AI understands and does the technical work for you!

## 🚀 Getting Started (It's Really Simple!)

### What You Need:
- A computer with internet
- 10 minutes to set up
- That's it!

### Three Simple Steps:

#### 1. Get the Website Template
```bash
git clone https://github.com/builtbyV/ai-website-builder.git
cd ai-website-builder
```

#### 2. Install AI Assistants
Run our setup script:
```bash
bash setup.sh
```

This will:
- ✅ Check your computer is ready
- ✅ Install Claude Code and/or OpenAI Codex CLI
- ✅ Set everything up for you
- ✅ Give you a quick reference guide

#### 3. Start Building!
With Claude Code:
```bash
claude
```

Or with OpenAI Codex:
```bash
codex
```

That's it! Now just tell your AI assistant what you want:
- "Hi Claude, I want to build a website for my bakery"
- "Can you make the header include our logo?"
- "Add a section showing our daily specials"

## 💬 Your First Conversation

Here's what a real conversation looks like:

**You:** "Hi, can you help me understand this website project?"

**AI:** "I'll analyze your project... This is a modern website template with a blue design. You have a homepage with navigation, hero section, features, pricing, and testimonials. Would you like me to explain any specific part?"

**You:** "I want to change it to a pizza restaurant website"

**AI:** "I'll help you transform this into a pizza restaurant website! Let me update the content and styling. I'll change the hero section, update the navigation, and adjust the color scheme to be more appetizing. Should I proceed?"

**You:** "Yes please!"

*The AI then makes all the changes and shows you what was updated*

## 🎨 Common Things People Ask Their AI Assistant

### Making Changes:
- "Change the business name to Tony's Pizza"
- "Make the background red instead of blue"
- "Add our phone number to the top"
- "Make the text bigger - my customers are older"

### Adding Content:
- "Add photos of our best dishes"
- "Create a menu page"
- "Add customer reviews"
- "Include our story in an about section"

### Making it Professional:
- "Make sure it works on phones"
- "Help people find us on Google"
- "Add a contact form"
- "Make it load faster"

### Publishing:
- "I'm ready to make it live"
- "Help me put this online"
- "How do people see my website?"

## 📱 See Your Changes Instantly

You'll want to use two terminal windows:
- **Terminal 1**: Run your website preview
- **Terminal 2**: Chat with your AI assistant

### Terminal 1 - Website Preview:
```bash
npm run dev
```
Then open your browser to `http://localhost:5173`

### Terminal 2 - AI Assistant:
```bash
cd /path/to/your/project  # Navigate to your website folder
claude  # or codex
```

Now you can chat with your AI in Terminal 2 and see changes instantly in your browser!

## 🌐 Making Your Website Live

When you're happy with your website, just tell your AI:
- "I want to publish my website"
- "Make this live on the internet"
- "Help me share this with customers"

Your AI assistant will:
- Ask for your confirmation
- Make sure everything looks good
- Publish it to the internet
- Give you the link to share

## 💡 Tips for Talking to Your AI

### Be Natural:
- ❌ DON'T: "Modify the CSS property background-color of the hero section"
- ✅ DO: "Make the top part of my website blue"

### Be Specific When Needed:
- ❌ DON'T: "Change the color" (which color? where?)
- ✅ DO: "Make the header background navy blue"

### Ask for Help:
- "I'm not sure how to describe this..."
- "Can you show me some options?"
- "What would look good here?"

### Review Changes:
- Your AI will always show you what it's about to change
- You can say "yes", "no", or "can you try something else?"

## ❓ Common Questions

**Q: Do I need to know how to code?**
A: Not at all! Just describe what you want in your own words.

**Q: What if I make a mistake?**
A: Just tell your AI to undo it or change it back. Everything is saved, so you can't break anything.

**Q: How much does this cost?**
A: The template is free! Both AI tools are free to install. Claude Code requires an Anthropic account, and Codex CLI needs an OpenAI account (new users get $5 free credit).

**Q: Can I add my own images?**
A: Yes! Put them in the `public/images/` folder and tell your AI to use them.

**Q: What if I get stuck?**
A: Just ask your AI! Say "I'm stuck" or "Help me understand this" and it will guide you.

## 🚀 What's Included

Your website comes with:
- 📱 Works on all devices (phones, tablets, computers)
- 🎨 Modern, professional design
- ⚡ Super fast loading
- 🔍 Google-friendly (SEO ready)
- 🔒 Secure and reliable
- 📊 Easy to update anytime

## 🆘 Getting Help

### If Claude Code won't start:
1. Make sure you're in your project folder
2. Try: `npm install -g @anthropic-ai/claude-code`
3. Run: `claude` again

### If Codex CLI won't start:
1. Make sure you exported your OpenAI API key
2. Try: `npm install -g @openai/codex`
3. Run: `codex` again

### If your website won't preview:
1. Run: `npm install` 
2. Then: `npm run dev`
3. Open: `http://localhost:5173`

### For everything else:
Just ask your AI assistant! They can help with technical issues too.

## 🛠️ Optional: Easy Text Editors

While your AI assistant handles most changes, you might want to make quick edits yourself. Here are free, beginner-friendly editors:

### Visual Studio Code (Recommended)
- **Download**: [code.visualstudio.com](https://code.visualstudio.com)
- **Why**: Most popular, free, works on all computers
- **Tip**: It highlights code in colors making it easier to read

### Simple Alternatives:
- **Sublime Text**: [sublimetext.com](https://www.sublimetext.com) - Clean, fast, and simple
- **Mac**: TextEdit (already installed) - Just switch to "Plain Text" mode
- **Online**: [vscode.dev](https://vscode.dev) - Works in your browser, no installation needed!

**Remember**: You don't need these! Your AI assistant can make all changes for you. These are just options if you prefer to edit text directly.

## 📚 Learn More

- **Claude Code Guide**: [Getting Started with Claude Code](https://docs.anthropic.com/en/docs/claude-code/quickstart)
- **OpenAI Codex Guide**: [Getting Started with Codex CLI](https://help.openai.com/en/articles/11096431-openai-codex-cli-getting-started)

## 🎉 You're Ready!

That's all you need to know! No complicated manuals, no coding bootcamps. Just:

1. Install your AI assistant ✓
2. Start chatting ✓
3. Build your website ✓

Remember: If you can describe what you want, your AI can build it for you.

---

Assembled by [V](https://v.ee) to make web development accessible to everyone.