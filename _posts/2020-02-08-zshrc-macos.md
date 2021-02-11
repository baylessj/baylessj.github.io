---
layout: post
tags: [productivity, macos]
title: "~ as Home does not work in MacOS .zshrc"
---

I recently picked up a 2015 MBP to use as a development machine for my side
project, [auToDo](https://autodo.app), since Apple won't let you make iOS apps without a Mac. I'm
not thrilled to be developing on a platform other than my beloved [Pop! OS](https://system76.com/pop),
but it's at least still a \*nix based system.

I was glad to see that, as of Catalina, MacOS uses [Zsh](https://www.zsh.org/) as its default shell.
I use Zsh as my default shell on my linux machine so I was excited to simply
drop in my `.zshrc` file from the linux machine. For the most part that worked,
after installing [Oh-My-Zsh](https://ohmyz.sh/) and the other usual things, but running `flutter`
did not.

This was a bit of an issue since the MacBook's main purpose in life was to be a
flutter dev machine. I spent about half an hour verifying that I had all of the
proper executables installed for Flutter and that they had the right permissions,
only to realize that the issue was very simple but not immediately obvious.

The `~` symbol does not expand to `/home/{USER_NAME}/` in a `.zshrc` file on MacOS
like it does in Pop! OS. I had been using the `~` symbol to point to the location
of the flutter binaries on my `PATH`, which worked on my linux machine but not
on the MacBook. I changed these symbols to the full `/home/{USER_NAME}/` string
in my `.zshrc` and everything worked fine and dandy for Flutter.

Don't be like me, use full paths in your Mac's `.zshrc` file.
