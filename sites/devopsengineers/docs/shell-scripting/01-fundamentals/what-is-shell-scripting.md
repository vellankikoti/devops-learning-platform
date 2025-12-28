---
sidebar_position: 1
title: "What Is Shell Scripting?"
---

# What is Shell Scripting? (Actually)

Let me be straight with you: shell scripting is just writing down commands you'd type manually, but in a file so you can run them again.

That's it.

No magic. No complexity. Just commands in a file.

But here's the thing: **That simplicity is powerful.**

## The Shell (What You're Actually Using)

When you open a terminal and type commands, you're using a shell. Probably bash. Maybe zsh. Doesn't matter which one for now.

The shell is what interprets your commands. It's what talks to Linux for you.

**A shell script is just a file full of those commands.**

That's the whole concept. Commands in a file. Run the file, run the commands.

## Why Script? (The Real Reason)

I'll give you an example.

Every Monday, I used to:
1. SSH into three servers
2. Check disk space
3. Check if services were running
4. Review logs for errors
5. Send a report

It took 30 minutes. Every Monday. Same thing. Every time.

Then I wrote a script. Now it takes 30 seconds. Same results. Less work.

**That's why you script. To stop doing the same thing over and over.**

## Your First Script (Let's Actually Write One)

Open a terminal. Create a file:

```bash
nano hello.sh
```

Type this:

```bash
#!/bin/bash
echo "Hello, World!"
```

Save it. Make it executable:

```bash
chmod +x hello.sh
```

Run it:

```bash
./hello.sh
```

**That's a script. You just wrote one.**

The `#!/bin/bash` line tells Linux to use bash to run the script. The `echo` command prints text. That's it.

## What Scripts Actually Do

Scripts automate tasks. That's their job.

- Install software? Script it.
- Deploy applications? Script it.
- Backup files? Script it.
- Check system health? Script it.
- Process logs? Script it.

**If you do it more than once, script it.**

## Common Shells (Which One?)

### Bash (The Default)

Bash is what most people use. It's everywhere. It's what you'll probably use.

**My take**: Start with bash. Learn it well. You can learn others later if you need to.

### Zsh (The Popular Alternative)

Zsh is what some people prefer. It has nice features. But it's not bash.

**My take**: Use bash for scripts. Use zsh for your interactive shell if you want. But write scripts in bash. It's more portable.

### sh (The Basic One)

sh is the basic shell. Bash is compatible with it. Mostly.

**My take**: Don't worry about sh. Write bash scripts. They'll work.

## What Makes a Good Script?

A good script:
- **Does one thing well** - Don't try to do everything
- **Is readable** - Future you will thank present you
- **Handles errors** - Things break. Scripts should handle it
- **Is documented** - Comments explain why, not what
- **Works reliably** - Same input, same output, every time

**That's it. That's what makes a good script.**

## The Truth About Scripting

Scripting isn't programming. It's automation.

You're not building applications. You're automating tasks. You're solving problems.

**That mindset shift matters.**

Don't try to write perfect code. Write scripts that work. That solve problems. That save time.

Perfect can come later. Working comes first.

## Common Uses (What You'll Actually Do)

### System Administration

Check disk space. Monitor services. Clean up logs. Restart things.

**Real example**: I have a script that checks disk space on all servers and emails me if any are above 80%. Runs daily. Saves me from surprises.

### Deployment

Deploy applications. Update configurations. Roll back if needed.

**Real example**: My deployment script backs up the current version, deploys the new one, runs tests, and rolls back if tests fail. One command. Done.

### Data Processing

Process logs. Extract information. Generate reports.

**Real example**: I have a script that processes web server logs, extracts error rates, and generates a daily report. Runs automatically. I just read the report.

### Automation

Automate anything repetitive. Anything.

**Real example**: I automated my morning routine. Check servers. Review logs. Generate reports. All automated. I just review results.

## What's Next?

Now that you know what scripting is, let's talk about [Script Structure](/docs/shell-scripting/fundamentals/script-structure). We'll cover the parts every script needs. The boring but essential stuff.

Or jump ahead. Your call. But understanding script structure makes everything else easier.

---

> **Personal note**: My first script was terrible. It worked, but it was terrible. That's fine. Scripts don't need to be perfect. They need to work. You can make them better later.
