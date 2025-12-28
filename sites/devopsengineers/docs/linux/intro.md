---
sidebar_position: 1
title: Linux Fundamentals for DevOps
---

# Linux: My Journey, Your Foundation

Look, I'm going to be honest with you. When I first saw a Linux terminal, I was terrified. All those commands. All that text. No buttons to click. No icons to point at.

I almost gave up.

But then something clicked. And now? Linux is like a second language. I think in commands. I dream in scripts. (Okay, maybe not the dreaming part, but you get the idea.)

This guide? It's everything I wish someone had told me when I started. No fluff. No theory without practice. Just real stuff that works.

## Why Linux? The Uncomfortable Truth

Here's the thing nobody tells you: **You can't avoid Linux in DevOps.**

I tried. Oh, I tried. I thought, "Maybe I can just use Windows Server and be fine." Nope. Cloud? Linux. Containers? Linux. CI/CD? Linux. Kubernetes? Linux.

It's everywhere.

But here's what they also don't tell you: **Once you get it, you'll wonder how you lived without it.**

Linux is like learning to drive a manual transmission. At first, it's frustrating. You stall. You grind gears. You think automatic is easier.

Then one day, you get it. And you realize: manual gives you control. Linux gives you control.

## What You're Actually Learning

This isn't about memorizing commands. Anyone can do that. This is about understanding how Linux thinks. How it works. Why it does things the way it does.

Once you understand that, you can figure out anything. New command? No problem. New problem? You'll know where to look.

That's the difference between someone who knows Linux commands and someone who understands Linux.

## The Modules (What We're Actually Covering)

I've organized this into 14 modules. Not because 14 is a magic number, but because it's how I actually learned. Each one builds on the last. Skip around if you want, but you'll end up coming back.

### Getting Started (Module 1)
What Linux actually is. Not the marketing version. The real version. Why it exists. How it works. What makes it different.

**Why this matters**: You can't master something you don't understand. Understanding Linux's philosophy makes everything else make sense.

### Command Line Basics (Module 2)
The terminal. Your new best friend. Or worst enemy. Depends on the day.

We'll cover the commands you'll use every single day. Not a comprehensive list of every command ever. Just the ones that matter.

**Why this matters**: Everything in Linux happens through the command line. Get comfortable here, and everything else is easier.

### File System (Module 3)
Linux's file system is weird. At first. Then it's brilliant. Everything is a file. Directories are organized logically. Once you see the pattern, you'll never get lost.

**Why this matters**: You'll spend most of your time working with files. Understanding the file system is understanding Linux.

### Text Editors (Module 4)
vi/vim. The editor everyone loves to hate. Until they don't.

I'll be honest: I avoided vim for years. I used nano. I used GUI editors. Then I had to edit a file on a server with only vim available. I learned vim in one panicked afternoon.

Now? I can't imagine using anything else.

**Why this matters**: You'll edit files on servers. Servers don't have GUIs. Learn vim now, or learn it when you're panicking at 2 AM.

### Process Management (Module 5)
What's running? Why is it running? How do I stop it? How do I make it run in the background?

Processes are Linux's way of organizing work. Understand processes, and you understand how Linux actually works.

**Why this matters**: Everything is a process. Understanding processes is understanding Linux.

### Package Management (Module 6)
Installing software. Updating software. Removing software. It should be simple. Sometimes it is. Sometimes it isn't.

We'll cover apt (Debian/Ubuntu) and yum/dnf (RHEL/CentOS). Why? Because those are what you'll actually use.

**Why this matters**: You'll install software. A lot. Package managers make it easy. When they work. We'll cover when they don't, too.

### System Services (Module 7)
systemd. The service manager that replaced everything. Love it or hate it, it's what you'll use.

We'll cover how to start services, stop services, enable services, disable services. The basics. Then we'll cover the stuff that actually matters: troubleshooting.

**Why this matters**: Services are how Linux runs things automatically. Understanding services is understanding automation.

### Networking (Module 8)
Networks. IP addresses. Ports. Firewalls. SSH.

This is where a lot of people get lost. Don't. Networking is just connections. Once you see it that way, it's simple.

**Why this matters**: Everything connects. Understanding networking is understanding how systems talk to each other.

### User Management (Module 9)
Users. Groups. Permissions. Who can do what.

This is security basics. Not advanced security. Just the stuff you need to know so you don't accidentally break things. Or let others break things.

**Why this matters**: Permissions are how Linux stays secure. Understanding permissions is understanding security.

### Storage Management (Module 10)
Disks. Partitions. Filesystems. Mounting. LVM.

Storage is boring until you run out of space. Then it's the most important thing in the world.

**Why this matters**: Everything is stored somewhere. Understanding storage is understanding where your data lives.

### Logging & Monitoring (Module 11)
Logs. Where problems hide. And where solutions live.

We'll cover where logs are, how to read them, how to find what you need. Because when something breaks, logs are your first clue.

**Why this matters**: Problems happen. Logs tell you why. Understanding logs is understanding troubleshooting.

### Security (Module 12)
Security. The thing everyone says is important but nobody wants to deal with.

We'll cover the basics. Firewalls. SSH hardening. Basic hardening. Not everything. Just enough to not be the weakest link.

**Why this matters**: Security breaches happen. Basic security prevents most of them. Understanding security is understanding protection.

### Advanced Topics (Module 13)
Kernel. Modules. Performance tuning. The deep stuff.

This is optional. Unless you want to understand Linux deeply. Then it's essential.

**Why this matters**: Advanced topics are what separate users from experts. Understanding the kernel is understanding Linux.

### DevOps Integration (Module 14)
Linux in CI/CD. Linux in containers. Linux in the cloud.

This is where it all comes together. Linux skills applied to DevOps workflows.

**Why this matters**: DevOps is Linux. Understanding Linux in DevOps is understanding DevOps.

## How to Use This Guide

I'm not going to tell you to read it in order. Do what works for you.

But here's what I will tell you: **Practice. Actually do the commands. Don't just read.**

I've included examples. Run them. Break them. Fix them. That's how you learn.

Each module has:
- **What it is**: The concept
- **Why it matters**: Why you should care
- **How to use it**: The commands
- **Real examples**: Stuff you'll actually do
- **Common mistakes**: Things I've done wrong so you don't have to

## A Personal Note

I'm writing this because I remember what it was like to be lost. To see a command and have no idea what it does. To break something and not know how to fix it.

This guide is my attempt to make that easier for you.

It's not perfect. It's not comprehensive. But it's honest. And it's based on what actually works.

Linux changed my career. It can change yours too.

## Let's Begin

Start with [What is Linux?](/docs/linux/getting-started/what-is-linux). We'll cover what Linux actually is, not the marketing version.

Or jump around. Your call. But I'd recommend starting at the beginning. The foundation matters.

---

> **One last thing**: Linux has a learning curve. It's steep at first. Then it flattens. Then it becomes second nature. Stick with it. The curve is worth it.
