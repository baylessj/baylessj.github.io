---
layout: post
tags: [productivity]
title: Zettelkasten Tooling Updates
---

While I had posted [before](https://jonathanbayless.com/2020/03/09/zettelkasten-vimwiki.html) about how I felt that I had found the ideal tooling for my [Zettelkasten](https://zettelkasten.de) in [VimWiki](https://vimwiki.github.io), I hit some growing pains with the toolset as I continued to add to my notes. When my notes were fairly small it made a lot of sense to keep all of the notes in one, large document, but that got to be difficult to work with. My Zettelkasten is still far from huge compared to the examples of others on the internet; it is around 250 unique notes at the time of writing. I bounced around to a couple other tools when I decided to move away from VimWiki and I am happily (for now, I suppose) using [Foam](https://foambubble.github.io).

## Attempts to scale VimWiki

I don't intend to imply that I jumped ship from VimWiki as soon as editing my notes became the slightest bit difficult, quite the opposite in fact. I prefer using Vim for most of my text editing needs so staying in Vim to edit my notes reduced the resistance for switching mental modes to taking notes from my usual code writing. I found two additions to my VimWiki workflow that made editing easier.

The first addition was isn't a dedicated tool, really, but was a new addition to my Vim skills. I learned more about folding sections in Vim and set up my config to indent VimWiki headers. This allowed me to reduce the visual clutter of the many notes in the wiki file. This created a new problem, though, because I used the first line or two of each note as a way of determining what it was about when adding backlinks. This meant that I had to constantly fold and unfold notes, defeating most of the approach's benefits.

The second addition was an [excellent plugin](https://gist.github.com/EinfachTool/9071573) for Vim that allowed me to view the VimWiki headers in a standard ctags sidebar. This made it possible to see the hierarchy of notes based on their Zettelkasten tags in a simple viewer. This had the same issue as the folding addition, though, in that I couldn't see the description when trying to make links between documents. It was an improvement but I still struggled to find the right place to add new notes and to find existing notes when creating links.

## Restructuring to one file per note

It became pretty clear that the recommended folder structure for a Zettelkasten in most tools is to use one markdown file for each note. This adds a bit more of a clear hierarchical structure to the notes than Luhman seemed to recommend in his personal Zettelkasten, but I actually have found this structure to be an improvement. The consensus seems to be a bit split on file naming, whether to use descriptive names or just the Zettelkasten identifier. I chose to put both in the file name, and so far it has made for a nice balance of easy discoverability of the note's topic and conciseness. The recommended structure for [Dendron](https://dendron.so) used one large root folder and dots to indicate the document hierarchy. I found this large folder to have many of the same shortcomings that the single VimWiki had, it was hard to navigate. The nested folder structure gave me the ability to easily find notes and only see the notes that I was concerned with.

## Obsidian

I found out about [Obsidian](https://obsidian.md) from their beta announcement on Hacker News right around the time that I started to hit those growing pains with VimWiki. This convenient timing combined with the excellent feature set of Obsidian's app made it a perfect choice for switching away from VimWiki. I was more easily able to create and edit links in Obsidian and the Obsidian editor added a very neat graph view showing the relationship between notes. This graph view helped cement for me the idea that the Zettelkasten should be a "second brain" with each note as a neuron connecting to others to form a brain-like network.

It was much easier to add a lot more information to my Zettelkasten when using Obsidian as the editor. The folder based structure made it easier to find the right place to add items and the autocompletion for adding links between notes helped me connect notes better than before. The autocompletion wasn't great though; it seemed to look for any note name that contained one of the letters in the search rather than considering the search to be a real word. This behavior meant that I often had to type out the whole name of the note anyways.

## Dendron

My issues with the link autocompletion and a worry about Obsidian's licensing with work-related notes led me to look further for a similar Zettelkasten tool. I also discovered [Dendron](https://dendron.so) through a Hacker News post and liked that it was built on Visual Studio Code rather than a standalone editor. Visual Studio Code is my other editor of choice along with Vim so using a Zettelkasten tool in VSCode would give me that same-environment benefit that VimWiki had. Switching to Visual Studio Code brought back a number of of convenient text editing shortcuts that I hadn't realized I had missed until I switched, namely the ability to delete a whole line in a keyboard shortcut.

Dendron's link autocompletion also seemed to have issues, though. It wouldn't split up search queries into individual letters like Obsidian, thankfully, but often the plugin would crash or would it fail to redirect me to the linked file properly. The graph view would similarly crash quite often. This is all understandable given that Dendron is in a beta stage currently, but I was a bit frustrated with the instability given how much I relied on the tool for note taking.

## Foam

Once again, I found a new option for my Zettelkasten through a Hacker News post. This time the tool was a very similar alternative to Dendron, a set of Visual Studio Code plugins called [Foam](https://foambubble.github.io). Foam covered a similar feature set as Obsidian and Dendron with the addition of a Jekyll/Github Pages integration. I hope to, at some point, clean up my Zettelkasten and get it added to my personal site here since it can be added to a Jekyll site. Foam didn't add much other new functionality besides that, but so far Foam has been able to reliably handle my ever-growing Zettelkasten with no crashes or major bugs. The link autocompletion is _excellent_ so I am able to write links to other documents without the cognitive overload of trying to remember their Zettelkasten identifiers. The graph view isn't quite as nice as Obsidian's but it does the trick, showing me what notes have proper links and which ones need some attention.

Overall, I'm very happy with Foam. The other tools I tested along the way were suitable but I've found a great fit for my workflow in Foam. I'll be sure to report back with a follow-up blog post again as my notes grow further, hopefully I'll be able to report that Foam still fits my needs.
