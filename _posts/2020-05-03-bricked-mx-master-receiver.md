---
layout: post
tags: [productivity, bugfix]
title: Fixing a soft-bricked Logitech Receiver with fwupdmgr
---

I was very excited for the 20.04 LTS release of [Pop!\_OS](https://pop.system76.com/) that came out a few
days ago. The addition of automatic window tiling and the various GNOME improvements
that came with the update were well worth the move from 19.10. After a few days
of using the update I still stand by my opinion that the upgrade was worthwhile,
but it wasn't an easy transition.

For starters, the 20.04 upgrade with `pop-upgrade` didn't like the configuration
of my computer's hard-drives in `/etc/fstab` -- but that's understandable given
that there's three drives and a mix on windows partitions on the non-boot ones.
A fresh install took care of that issue, and all of the drives are accessible
and running fine now. I did not, however, expect that my [Logitech MX Master 2S](https://www.logitech.com/en-ph/product/mx-master-2s-flow)
mouse would fall victim to the upgrade process.

Somewhere along the way in the fresh install of Pop!\_OS 20.04, the firmware update
manager utility decided to run. This utility decided that the firmware for the
Logitech Unifying Receiver, the USB dongle for the mouse, needed updating. That
would have been fine, except the update encountered an "unexpected error" and cut
out half-way through the update. This left the mouse dongle unusable and the
mouse refused to connect to it.

A quick check of `lsusb | grep Logitech` gave me `Bus 003 Device 005: ID 046d:aaac Logitech, Inc. USB BootLoader` where the dongle was plugged in. This was good news in that the dongle
was still communicating over USB and was not hard-bricked, but it clearly isn't
supposed to be a "BootLoader" device. The Pop!\_OS firmware upgrade utility in
the Settings menu didn't show that the device was eligible for an upgrade, but I
assumed that somehow forcing an update would improve the situation. Thankfully I
was introduced to the command line version of the update tool from a Stack Overflow
post. Running `fwupdmgr update` turned out to be the solution, it correctly
identified that the "USB BootLoader" device was supposed to be a Logitech Receiver
and got it updated. It took a minute to run the upgrade and once it finished I was
able to connect the mouse to the receiver again.

Upgrading to Pop!\_OS 20.04 was a tumultuous journey for my mouse, but it introduced
me to the more powerful command line version of the firmware upgrade utility.
