---
published: true
layout: post
title: "Reverting to a previous Kernel"
date: 2017-03-13 11:40:00 +1000
comments: true
categories:
- Ubuntu
- kernel
- downgrade
---

I haven't needed to downgrade my kernel for a while. I was using Ubuntu's 14.04 LTS (long time support) support for a few years, and it was so stable that
I just run the following with no problems.

    sudo apt-get update
    sudo apt-get upgrade

But recently I got a new laptop with the latest chipsets and peripherals and decided to upgrade to the new Ubuntu Xenial 16.04 LTS 
while I'm at it.

I'm sad to say that the combination of new distro with bleeding edge hardware has twice given me a problem. <!-- More -->

I'm sure it'll be stable soon but in the mean time
I've had to revert to a previous kernel twice now, so this blog will help me remember what to do if it happens again.

The symptoms are dramatic. After a re-boot my laptop had no network drivers and no graphics drivers,
the display reverts to an emergency emulated mode which has very slow mouse response times and it looks huge,
like a "my first computer" children's toy!

Not what I want from my brand new hardware.

I don't have time or want to fix all the drivers, so the quickest fix is to revert to a previous kernel that was working, remove the broken one, which 
has the effect of blacklisting it then try the next kernel when it comes out. 

### Howto
##### Boot from previous kernel
1. Hold the shift key while booting to get to the `grub` options
2. Choose advanced grub options
3. Make a note of the current kernel numbers (top of the list) you'll need them later to remove it.
4. Use the arrow key to pick a previous kernel and boot into it.

##### Remove the dodgy kernel
This will remove the broken kernel and drivers, and lets the package manager know that you don't want it again if you do an update.
You should remove the specific broken kernel and it's headers, don't remove the super package `linux-generic` this is the package that 
Ubuntu uses to upgrade the kernel and headers when they become available. If you remove it you wont get kernel updates automatically and will have to 
specifically run `apt-get` to get them.

    # use the kernel numbers from previous step to confirm that the broken kernel has been installed
    # eg if the currently broken kernel was linux-image-4.4.0-64-generic it should show up in the following command.
    dpkg -l | grep linux-image
    
    # remove the broken kernel
    sudo apt-get purge linux-image-4.4.0-64-generic

    # remove its headers too
    sudo apt-get purge linux-headers-4.4.0-64-generic

##### Reboot
On reboot you should boot into the previous safe version, hold shift down on boot and confirm that the broken kernel is not a
choice in the grub advanced settings.

Because we haven't removed the linux-generic package itself Ubuntu will still attempt to get a new kernel when one is available,
just not the one you specifically purged.

That's it.
