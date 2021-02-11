---
layout: post
title: GBoards Gergoplex Keyboard Review
tags: [productivity, keyboards]
image:
  - src: gergoplex1.jpg
    alt: angled shot of the Gergoplex
  - src: gergoplex2.jpg
    alt: height comparison of the Gergoplex and HotDox
  - src: gergoplex3.jpg
    alt: wide angle shot of both halves
  - src: gergoplex4.jpg
    alt: GergoPlex overlaid on the HotDox
---

{% assign image=page.image[0] %}
{% include srcset-sizes.html %}

I recently came across the GBoards line of low-profile keyboards and immediately wanted to try out this thinner design. I still stand by my previous positive review of the [Alpaca Keyboards HotDox](https://jonathanbayless.com/2019/09/16/hotdox-review.html) that I was using as my daily driver, but the GBoards designs addressed a couple of my pain points with it:

- The height of the HotDox, and most normal keyboards, for that matter, essentially required wrist rests. The addition of wrist rests was an improvement in ergonomics but annoying to keep in place on my desk and keep clean.
- The lighter switch springs in the GBoards choc switches weren't what attracted me to the keyboards in the first place, but the 20g springs are magnificent. I put silent red switches in my HotDox, which are pretty light switches, but the 20g choc switches make the Cherry switches feel like molasses.
- The thumb cluster of the HotDox was too far of a reach to be comfortable. I found myself only using the two 2u keys and the innermost of the lowest row of keys with my thumbs. The GergoPlex has an excellently designed thumb cluster, although part of me misses having a second 2u key on the cluster.

The Gergoplex builds on the admirable qualities of the HotDox and addresses its minor flaws well. The learning curve to adjust to the Gergoplex from the HotDox is, surprisingly, about the same magnitude as my transition from a staggered, traditional layout to the HotDox. I have had the keyboard for a few days now and I'm just starting to get back to my normal typing speed. While the transition to using this keyboard has not been easy I can tell now that it is an improvement.

## Layout and Ergonomics

{% assign image=page.image[3] %}
{% include srcset-sizes.html %}

The obvious difference between the Gergoplex and a traditional keyboad is its split, ergonomic layout. I've discussed this at length in my review of my HotDox, though, so I'll focus mainly on the differences between the Gergoplex and other similar split ergo keyboards that I've used.

The Gergoplex is the first keyboard I've used with [Kailh Choc](http://www.kailh.com/en/Products/Ks/CS/) switches. I tend to be a pretty heavy-handed typer so the shallow, light switches are a big adjustment to my normal typing habits. I started out by bottoming out hard on the choc switches but I have been learning to _tap_ the keys rather than forcing them down now. This hasn't yet benefitted my typing speed, since I'm still getting used to the layout of the Gergoplex, but I have found the switches to be much more comfortable for a full day of writing code.

I have been comfortably able to use all three of the thumb keys on the Gergoplex's thumb cluster, which is a big improvement over my experience with the Hotdox and Iris. None of the thumb cluster keys are too far away from resting position or on a second row that requires angling my wrist forward or backward. I sometimes think that adding a fourth key to the thumb cluster would simplify the keymap pretty significantly, but I'm not sure that it would be feasible to add another key without comprising on the comfortable ergonomics of the current layout.

Similarly, the 3x5 grid for the alpha characters makes the keymap a bit difficult to put together but is a big improvement for the ergonomics of the board. I would often reach over two columns or across two or three acts with my HotDox in order to reach every key but I never have to move my fingers much at all with the Gergoplex. This is another detail of the keyboard that is minor at first but becomes quite nice after a full day of programming.

{% assign image=page.image[1] %}
{% include srcset-sizes.html %}

## Putting Together a Keymap

The Gergoplex, like many other split, ergonomic keyboards, uses the wonderful [QMK](https://docs.qmk.fm/#/) firmware. The default keymap for the Gergoplex isn't _bad_ by any means, but wasn't what I was looking for. Though I took issue with some points of the HotDox's design I was happy with [my keymap for it](https://github.com/baylessj/hotdox-qmk). Moving this keymap to the Gergoplex could not be done without a fair bit of rearranging given the reduction in the number of keys. My primary tool for fitting the required characters into the Gergoplex's small footprint was QMK's [Layers](https://docs.qmk.fm/#/feature_layers). I used two layers in my previous keymap, both activated by holding a dedicated key. The first layer simply turned the keys on the right hand side into arrow keys and home and end and such. The second layer turned the same group of keys into a numpad. These layers were a convenience; all of the above functionality was accessible through other keys outside of the easy-to-reach grid. The Gergoplex, on the other hand, _required_ such layers in order to input all of the needed characters.

I kept the arrow key and numpad portions of these layers as I had before. I had to rely on another one of QMK's unique features to access these layers now though with the Gergoplex's limited number of keys. I now access the arrow key layer by setting the "a" key as a "Layer-Tap" QMK macro. When the "a" key is tapped it outputs an "a", like normal, but when that key is held then it activates the arrow key layer. This macro makes it possible to keep the same layers as I had with a larger keyboard. The difference between a tap and a hold is not _that_ much time, about a quarter of a second or so I think. This is a timing difference that I have mostly been able to get used to but was very difficult to work with when learning to type on the Gergoplex. Now that I'm close to a normal typing speed I don't spend very long with my finger held on one of thes layer-tap keys. These tap keys seem to also struggle a bit with differences in the order that the pressed keys are released; I have to be careful to release the tap key _after_ any other key that I wish to be output as the layer version.

I'm thinking it might be worth taking a look at changing some of the configuration options for these layer-tap keys. I have put all of the modifier keys, those outside of the alphabet, on layers, so I'm using them very often. I don't think I would rely on layers nearly as much if it weren't for programming, which uses a lot of special characters. Part of me is considering adding an additional layer for just these special characters, but for now I am doing alright with adding them to the previously open keys on my arrow key and numpad layers.

I have used an additional QMK macro to make up for the Gergoplex's lack of modifier keys, the aptly named mod-tap macro. This macro is very similar to the layer-tap key but instead activates a modifier key like control or alt. These macro keys suffer from the same timing and release order issues that the layer-tap keys do but are similarly getting more manageable as my typing speed increases.

One macro, of sorts, that is used extensively on the GBoards lineup of keyboards is the key combo. The GBoards keyboards are either small, like the Gergoplex, or even smaller. It's possible for the Gergoplex to be perfectly usable by just using layers and tap keys, but it's smaller cousins like the [Georgi](https://www.gboards.ca/product/georgi) and [Ginny](https://www.gboards.ca/product/ginni) require something closer to [stenography](https://en.wikipedia.org/wiki/Shorthand). This is where key combos come in. The combos also give keys multiple outputs like the tap keys but are dependent on multiple keys being tapped at the same time. This allows, for example, "o" and "p" to work normally when pressed independently but output a "backspace" command when the two are tapped at the same time. I have only incorporated this technique into my keymap to replace the backspace key but I think I might try to start moving other characters from layers to combos like this in the future. I've found the key combos to be a bit more difficult to get used to conceptually compared to the tap keys but I haven't found hardly any issues with timing on the key combos.

{% assign image=page.image[2] %}
{% include srcset-sizes.html %}

## Overall Impression

I am confident that the Gergoplex will be a more ergonomic keyboard for me in the long term and a joy to use. It has been difficult to get adjusted to using its innovative layout and I'm still fiddling with my QMK keymap, but the basis of the design is great. It is clear that this keyboard was designed after a long time of using similar split, ergonomic keyboards as it builds upon the highlights of other similar designs while addressing their flaws.

You can find my keymap for the Gergoplex in [my fork of QMK](https://github.com/baylessj/qmk_firmware).

You can buy a Gergoplex from [g Heavy Industries](https://www.gboards.ca/product/gergoplex).
