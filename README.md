# AI Website Builder 🤖

Build your website by just talking to AI in your own language - no coding required!

## 🎯 What is this?

This is a website template that lets you build and update your site by having conversations with AI assistants. Just describe what you want in your own language, and watch your website come to life!

### Choose Your AI Assistant:
- **Claude Code** - AI coding agent by Anthropic
- **OpenAI Codex CLI** - AI coding agent by OpenAI
- **Gemini CLI** - AI coding agent by Google

All understand natural language and can build your website - pick any one!

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
- A free GitHub account (needed later when you publish your site)
- 10 minutes to set up
- That's it!

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

### Three Simple Steps:

#### 1. Get the Website Template

Run these commands one at a time in Terminal:

**First** - Copy the template to your computer:
```bash
git clone https://github.com/builtbyV/ai-website-builder.git
```
Press Enter and wait until the download finishes.

💡 **Tip:** You'll know it's finished when you see your Terminal prompt (`$` or similar) again.

**Then** - Go into your project folder:
```bash
cd ai-website-builder
```
Press Enter.

**💡 Troubleshooting:**
- If you see 'No such file or directory', the download probably isn't complete yet. Wait a bit and try again.
- You should see `ai-website-builder` in your Terminal prompt after this command

#### 2. Install AI Assistants

In your Terminal window (make sure you're inside the `ai-website-builder` folder), run this command:
```bash
bash setup.sh
```

💡 **Don't worry if you see lots of text scrolling by—this is normal! Just wait until it stops and you see your Terminal prompt again.**

This command automatically does everything for you:
- ✅ Check your computer is ready
- ✅ Install Claude Code and/or OpenAI Codex CLI and/or Gemini CLI
- ✅ Set everything up for you
- ✅ Give you a quick reference guide

## 💻 Helpful Terminal Commands

Just a few commands you might need:

- `cd folder-name` - Go into a folder
- `cd ..` - Go back up one folder  
- `ls` - See what's in current folder (works in Git Bash on Windows too)
- `pwd` - See where you are
- `Ctrl+C` (or `Command+C` on Mac) - Stop something that's running

**Examples:**

Enter your project folder:
```bash
cd ai-website-builder
```

Go back to the previous folder:
```bash
cd ..
```

See what files are in current folder:
```bash
ls
```

Check which folder you're in:
```bash
pwd
```

#### 3. Start Building!

Choose your AI assistant and run one of these commands:

**For Claude Code:**
```bash
npx claude
```

**For OpenAI Codex:**
```bash
npx codex
```

**For Gemini CLI:**
```bash
npx gemini
```

**What this does:** Starts your AI assistant so you can chat directly in the Terminal.

That's it! Now just tell your AI assistant what you want:
- "Hi Claude, I want to build a website for my bakery"
- "Can you make the header include our logo?"
- "Add a section showing our daily specials"

💡 **Remember:** If you make a mistake, just tell your AI assistant to undo it - nothing will break!

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

You'll need two Terminal windows - one for your website preview, another for chatting with AI.

### Why Two Windows?
- **Window 1**: Keeps your website running so you can see it
- **Window 2**: Where you chat with your AI assistant

### How to Open a Second Terminal:

**On Mac:**
1. In Terminal, press `Command ⌘ + N`

**On Windows (Git Bash):**
1. Right-click in a folder and select "Git Bash Here" again

**On Linux:**
1. Press `Ctrl + Shift + N` in most terminals
Or open a new terminal from your applications

Click between windows to switch.

### Terminal 1 - Website Preview:

Run this command:
```bash
npm run dev
```

💡 **Tip:** Keep this window open! It needs to stay running for your preview to work.

**What this does:** This starts your website preview. After running it, open your browser and visit `http://localhost:5173` to see your website!

### Terminal 2 - AI Assistant:

**First** - Go to your project folder:
```bash
cd ai-website-builder
```

**Then** - Start your AI assistant:
```bash
npx claude
```
(Or use `npx codex` or `npx gemini` instead)

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
- Give you a public link you can share

## 🏠 Free Website Hosting with GitHub Pages

Your website will be hosted for FREE on GitHub Pages! Here's what you need to know:

### What is GitHub Pages?
GitHub Pages is a free service that hosts your website online:
- **Free hosting** from GitHub (the same place your code lives)
- **Your own web address** like `username.github.io/project-name`
- **Automatic updates** when you publish changes
- **No monthly fees** - completely free forever!

**Note:** To publish your website, you'll need a free GitHub account. Your AI assistant will guide you when it's time.

### Your Website Address Will Be:
- **GitHub Pages**: `https://[your-username].github.io/[repository-name]/`
- **Custom Domain** (optional): You can use your own domain like `mybusiness.com`

### How Publishing Works:
1. You make changes with your AI assistant
2. Say "I want to publish my website"
3. Your AI handles all the technical stuff
4. Your site goes live in 2-5 minutes!

### Creating Another Website:

Want to build another website? Here's how:

**Step 1** - Go back to your main folder:
```bash
cd ..
```

**Step 2** - Copy the template again with a new name (this creates a separate folder for your new website):
```bash
git clone https://github.com/builtbyV/ai-website-builder.git my-new-site
```

**Step 3** - Enter your new project:
```bash
cd my-new-site
```

**Step 4** - Run setup:
```bash
bash setup.sh
```

### Other Hosting Options:
While we recommend GitHub Pages, your AI assistant can also help you deploy to:
- **Cloudflare Pages** - Unlimited bandwidth
- **Netlify** - Drag & drop option
- **Vercel** - Advanced features

Just ask: "Can you help me deploy to Netlify instead?"

## 💡 Tips for Talking to Your AI

### Speak Your Language:
- You can talk to your AI in any language you're comfortable with
- Mix languages if you want - the AI will understand
- Technical terms work in any language

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
A: The template is free! All three AI tools are free to install:
- Claude Code requires an Anthropic account
- Codex CLI needs an OpenAI account (new users get $5 free credit)
- Gemini CLI works with your Google account (1,000 free requests/day) or API key

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

### If Something Goes Wrong:

**Don't worry, your website project and files are safe.** Closing Terminal or restarting setup won't erase your progress or content!

**Need to start over?**
1. Close all Terminal windows
2. Open a fresh Terminal
3. Start from Step 1 again

**Setup failed partway through?**
- Don't worry—just run `bash setup.sh` again
- It will skip what's already installed
- If still stuck, close Terminal and start fresh

### If Claude Code won't start:
1. Make sure you're in your project folder
2. Try: `npm install -g @anthropic-ai/claude-code`
3. Run: `npx claude` again

### If Codex CLI won't start:
1. Make sure you exported your OpenAI API key
2. Try: `npm install -g @openai/codex`
3. Run: `npx codex` again

### If Gemini CLI won't start:
1. Make sure you're in your project folder
2. Try: `npm install -g @google/gemini-cli`
3. Run: `npx gemini` again

### If your website won't preview:

**Follow these steps if your website won't preview:**

**Step 1** - Install required files:
```bash
npm install
```
💡 **This might take a few moments. Wait until you see your Terminal prompt again.**

**Step 2** - Start the preview server:
```bash
npm run dev
```

**Step 3** - Open your browser and go to:
`http://localhost:5173`

### For everything else:
Just ask your AI assistant! They can help with technical issues too. If you get stuck at any step, just type `help` or ask your AI assistant for assistance.

## 🛠️ Optional: Easy Text Editors

While your AI assistant handles most changes, you might want to make quick edits yourself. Here are free, beginner-friendly editors:

### Visual Studio Code (Recommended)
- **Download**: [code.visualstudio.com](https://code.visualstudio.com)
- **Why**: Most popular, free, works on all computers
- **Tip**: It highlights code in colors making it easier to read

### Simple Alternatives:
- **Sublime Text**: [sublimetext.com](https://www.sublimetext.com) - Clean, fast, and simple
- **Mac**: TextEdit (already installed) - Just switch to "Plain Text" mode
- **Windows**: Notepad (already installed) - Simple and basic
- **Linux**: Usually comes with gedit or similar
- **Online**: [vscode.dev](https://vscode.dev) - Works in your browser, no installation needed!

💡 **You don't need to use any editors if you don't want to!** Your AI assistant can handle everything. Editors are just there if you prefer making quick edits yourself.

## 📚 Learn More

- **Claude Code Guide**: [Getting Started with Claude Code](https://docs.anthropic.com/en/docs/claude-code/quickstart)
- **OpenAI Codex Guide**: [Getting Started with Codex CLI](https://help.openai.com/en/articles/11096431-openai-codex-cli-getting-started)
- **Gemini CLI Guide**: [Getting Started with Gemini CLI](https://github.com/google-gemini/gemini-cli)

## 🎉 You're Ready!

That's all you need to know! No complicated manuals, no coding bootcamps. Just:

1. Install your AI assistant ✓
2. Start chatting ✓
3. Build your website ✓

Remember: If you can describe what you want, your AI can build it for you.

💡 **Still stuck?** Don't hesitate to ask your AI assistant—it's always ready to help you through any issue!

---

Assembled by [V](https://v.ee) to make web development accessible to everyone.