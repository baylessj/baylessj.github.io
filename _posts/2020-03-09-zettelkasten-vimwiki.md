---
layout: post
tags: [productivity]
title: Vimwiki + Zettelkasten -- Note Taking Nirvana
hn-id: 22637482
---

I've been in a time of turmoil with note taking and text editing. I bounced around
between a few different editors before landing on Vim full-time. I experimented
with a [gitbook](https://gitbook.com), I used [Joplin](https://joplinapp.org) for a bit, and I wrote a lot down on paper
and post-it notes. As much as I love using pen and paper, I need to take notes
on a computer to ensure that they'll be with me everywhere. I looked for a way
to keep my notes in one place and, ideally, in one file. The **Zettelkasten**
method fit that bill exactly.

**Zettelkasten** is a German word that means "slip box". It's a note taking
method invented by [Niklas Luhmann](https://en.wikipedia.org/wiki/Niklas_Luhmann), a German Sociologist. Luhmann
wrote an impressive number of papers throughout his career using the Zettelkasten
method to collect his notes. His Zettelkasten was a physical box containing slips
of paper where he wrote his notes, hence the name. He stored every note he took as a slip in his Zettelkasten, creating a "second brain" of sorts that mirrored his knowledge.

Luhmann's own Zettelkasten defines the method. The fundamental tenets of the
method are derived from his approach. As mentioned before, Luhmann had only one
Zettelkasten throughout his entire life. Keeping these notes in one place
allowed him to accurately mirror his whole set of knowledge -- including the
convoluted associations between knowledge that seems separate at first glance.
He was able to reference lessons learned from his early career even in his last
writings. I, and many others today, choose to implement this idea by having one
Zettelkasten digital file rather than a physical box. It is easy to edit files
of a considerable size with Vim so there is no real worry of needing to split the Zettelkasten files up.

Without a sense of structure, a single file full of a life's work would become
impossible to navigate. The Zettelkasten method specifies that each slip should
have a unique ID value, like a key in a database. This ID value is used to
reference the slip from other notes in the future. Inter-note references can span
years and numerous subjects in between, so long as there is reason to mention one
in the context of the other.

It would be unreasonable to explicitly link to _every_ related note once the
Zettelkasten grows large, so a loose tree structure is recommended. There is no
formal requirement for choosing ID values, except that they should be unique, but
I prefer to organize notes somewhat hierarchically. A general note about Agile
meetings would get a high-level ID like #1a and a detailed note about timeboxing
Scrum standups would be nested below it as #1a1a1a. Each alternation between
alphabetical and numerical characters indicates a level of abstraction.

I initially wrote my Zettelkasten in a plain `.txt` file using a rough markdown
syntax. This was manageable until my Zettelkasten file grew to about 1000 lines,
and then it became a bit of a pain to navigate between linked notes. At this point
I turned to [Vimwiki](https://vimwiki.github.io/) to get the linking infrastructure for my Zettelkasten.
Vimwiki does a lot beyond the linking support that I am using it for, but I will
focus primarily on that subset of features here.

Each note in my Zettelkasten receives a unique ID of the form "1a1a1" and is listed
as a second level header in the `zettelkasten.wiki` file. It is then easy
to link to any other note in the Zettelkasten by adding a Vimwiki link to the note's
anchor, i.e. `[[#1a1a1|Link to other note]]`. Pressing enter when the cursor is
over the link in normal mode will jump to that note. The structure of the
Zettelkasten IDs make it easy to find a note's ID when putting in a link -- searching
for a general term associated with the desired note will lead to its parent note.

The Zettelkasten method has allowed me to start organizing my thoughts into a
digital "second brain", and using Vim and Vimwiki for editing makes it easy to
scale with my rapidly increasing set of notes. My notes are in plain-text and
backed up in multiple places, so I don't need to worry about vendor lock-in and
losing my notes. Using Zettelkasten with Vimwiki is just enough structure and tech
to make notetaking enjoyable, but not so much that it builds a fragile, short-lived
tech stack.
