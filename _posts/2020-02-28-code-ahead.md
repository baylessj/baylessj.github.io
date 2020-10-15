---
layout: post
title: Code Ahead - A Painful Read That Makes Some Valid Points 
categories:
  - blog
image:
  - src: codeahead.png 
    alt: Code Ahead Book Cover
---

{% assign image=page.image[0] %}
{% include srcset-sizes.html %}

# Code Ahead - A Painful Read That Makes Some Valid Points

I really don't like Yegor Bugayenko. The author of Code Ahead, a semi-autobiographical take on software engineering, comes across a condescending and annoying. The book's protagonist is clearly modeled after the author, and  he sucks. The protagonist plays a know-it-all, a nihilist, and a caricature of  the author's ideas. This creates a perfect storm of behavior that led to my  hatred of the character. 

That said, the book makes some good points.

## Tracking Performance

A recurring theme in Code Ahead is performance tracking. Management rightfully wants a reliable metric for a programmer's productivity, but that is not an easy ask. The protagonist argues for using closed tickets for tracking productivity. I agree with the core idea of this method. I do not, however, agree with the author's hypothetical scenario where programmers are paid as a function of their closed tickets. This payment structure is one of the many examples of  the author's cold, simplistic view on software development.

There is an interesting discussion between the book's characters on whether this method of tracking performance is _agile_. It is another process, after all, and it introduces a risk of the team's programmer's becoming feature factories. This is another reason that I do not agree with the author's suggestion to pay developers by their number of completed tickets; pushing one metric too hard will inevitably lead to the team becoming one dimensional in pursuit of the  metric.

The QA team in Code Ahead has a metric that is roughly the opposite of the developers' metric -- tickets opened. This is the opposite of the conventional team structure, but I am of the opinion that it is the correct approach. The QA team should be rewarded for finding defects in their testing. It is cheaper and faster to  fix bugs found before they reach the customer. Additionally, the QA team would have no tangible effect on the organization if their tests are always passing.

## The Definition of "Done"

A related question to the decision of what metric to track is the decision of  when to consider a ticket complete. This definition of "done" varies between  teams and is often the source of a lot of bugs and team conflicts. The  protagonist in Code Ahead rightly points out that this definition should be  very clearly understood by the team and its stakeholders. His recommended approach for making this clear to the team is to have the team decide on their definition as a group. I think this would be appropriate most of the team, but if a team has a lot of stakeholders with complex requirements then the average developer may not be able to make an informed opinion on what must constitute as "done".

## Bugayenko the Egoist

The primary reason for my dislike of Bugayenko is his character's Egoistic attitude. The beginning suggests to get a role where you can wield power over your coworkers without holding any real responsibility. The protagonist is playing "poker with Tony for a place in the hierarchy" while taking a software architect role for the supposed lack of responsibility with the position. Bugayenko says that his  goal with his role is to work exclusively on his own open-source projects while receiving a paycheck, bending his coworkers to his ideals, and incessantly  quoting Nietzche throughout. Seriously, the guy needs to stop with the appeals to Nietzche and other philosophers.  

## TL;DR

I like the points that the Code Ahead made, but I don't think I actually _enjoyed_ reading the book. I would recommend reading about the book's main discussion points elsewhere; it's not worth the ~$40 price tag.
