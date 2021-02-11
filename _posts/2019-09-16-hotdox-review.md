---
layout: post
tags: [productivity, keyboards]
title: "Alpaca Keyboards Hot Dox Review"
image:
  - src: keyboard1.jpg
    alt: keyboard photo
  - src: keyboard2.jpg
    alt: tented keyboard macro shot
---

{% assign image=page.image[0] %}
{% include srcset-sizes.html %}

I recently picked up a [Hot Dox](https://www.alpacakeyboards.com/) keyboard from [Alpaca Keyboards](https://www.alpacakeyboards.com/) as my introduction to the world of split ergonomic keyboards. My primary goals in moving from a traditional mechanical keyboard were to get an improvement in ergonomics and to get much more customization potential than I had with my current keyboards. The Hot Dox is acceptable on the ergonomics front and excellent on the customization front due to its use of the [QMK Firmware](https://qmk.fm/).

### Ergonomics

The layout of the Hot Dox differs in many ways from a traditional keyboard and, in my opinion, those differences are largely for the better. The Hot Dox is a clone of the [Ergodox](https://ergodox-ez.com/) keyboard, which is described as an _ortholinear, split keyboard_. For those who aren't familiar, I'll break down those adjectives individually.

#### Ortholinear

An _ortholinear_ keyboard is a keyboard where each of the keys are grouped in straight columns rather than in a staggered layout like a traditional keyboard. In my experience it is a surprisingly different experience to type on an ortholinear keyboard compared to a traditional; the keys are only moved a tiny bit on the keyboard but forcing the keys into perfect columns drastically changed the way my fingers moved to hit most keys. Hitting keys that are not on home row is achieved through a linear movement of the corresponding typing finger and there is no need for a change in hand orientation.

After a couple of months with my Hot Dox I still can't claim to be completely used to this new layout, but it makes a lot more sense than a staggered layout. It seems to me like a milder version of switching to a non-traditional layout like [Dvorak](https://en.m.wikipedia.org/wiki/Dvorak_Simplified_Keyboard)-- while there are pros to the changed layout, one will likely always have times when the have to switch back to a traditional layout. I have not had too hard of a time making the mental switch associated with using a traditional keyboard some times and the ortholinear layout at other times, but it is definitely still noticeable.

#### Split

A _split_ keyboard is very easily noticeable as such, the halves of the keyboard associated with each typing hand are, well, split apart. The main benefit of this design is ergonomics; it is a lot more natural to have your arms sitting even with your shoulders than to stick your hands in line with the middle of your ribcage like with a traditional keyboard. I don't have any [RSI](https://en.wikipedia.org/wiki/Repetitive_strain_injury) issues with my hands to combat so I don't have a huge need for the improved ergonomics but it helps me rest easier knowing that I'm doing less harm to my body by typing for so many hours a day.

One somewhat unintended benefit of the split layout is forcing good habit when typing. I had previously been pretty bad about moving my hands around the keyboard and off of home row but with the split keyboard it's impossible to accidentally start typing on the wrong hand's side of the keyboard. I've noticed that this has improved my typing form on traditional keyboards as well.

### QMK

The _QMK Firmware_ is without a doubt my favorite part of using this keyboard. This firmware allows you to change the behavior of every key on the keyboard to fit your preferences. The modifications to the key behavior is not restricted simply to the standard set of keys that can be accessed without holding any modifier keys, instead you can add up to 32 **layers** of different functionality. A layer is similar to the change from lowercase to uppercase that occurs when holding the shift key. I have one layer that allows me to use the arrow keys on the `i, j, k, l` keys so I don't have to move from home row, another layer that allows me to move the mouse with the same set of keys, and another layer that gives me a numpad around home row position. These layers give me all of the benefits of a full-size keyboard (plus some, in the case of the mouse keys) without ever having to leave home row.

You can find my QMK configuration file on my [github](https://github.com/baylessj/hotdox-qmk).

### Tenting Modification

{% assign image=page.image[1] %}
{% include srcset-sizes.html %}

I made one minor modification to my assembly of the keyboard that has made a decent improvement in my impression of its ergonomics. One popular configuration with split keyboards is a _tented_ configuration where the inside edge of each of the keyboard halves is raised somewhat. This puts your hands at a slight angle, which is a more natural way for them to sit. Some keyboards allow this behavior by default, such as the [Ergodox](https://ergodox-ez.com/), but the Hot Dox does not.

For \$4 and a trip to the hardware store, however, I was able to easily achieve some slight tenting to my keyboard. I got a set of 3mm x 16mm button head screw with a 2mm drive and a 3mm - 0.5 hex nut for each of the screws. I replaced the screws holding together the case on the inside corners with these longer screws, adjusted the hex nuts snug against the case, and had a nice tented keyboard setup.

### Overall Impressions

Making the switch to a split, ortholinear keyboard has been a difficult transition, but I've found that this keyboard makes it well worth it. My typing ability has improved on other keyboards as well, but the flexibility with the QMK Firmware allows me to be my most productive on this keyboard. 10/10 -- get a cool keyboard.
