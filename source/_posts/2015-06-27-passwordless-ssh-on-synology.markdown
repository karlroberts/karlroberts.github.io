---
layout: post
title: "passwordless ssh on synology"
date: 2015-06-27 17:43:13 +1000
comments: true
published: true
categories: 
- ssh
- passwordless
- synology
- rsync
---

I want the rsync user on my Synology box (called synology) to use ssh with no password. <!--more-->

First I create the ssh key

```
ssh-keygen -t rsa
```

When asked for the password for the key simply hit `enter` key, and again.
This will create a private key and public key in 

```
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
```

Over on the Synology box (I assume you have ssh'd there as root)

```
ssh root@synology
```

Some hoops need to be jumped.

By default you can't get to the home directory of a user, it is mapped to a fake place
Get around that by:-

* go to Users admin page
  - click advanced 
  - turn on "home services"

Now you need to modify the home dir permissions

```
cd /var/services/homes

chmod 755 user user # by default synology setts 777 and sshd is picky
```

Now you need to actually give your user a shell. 
as root edit `/etc/passwd`

You need an entry like

```
rsync:x:1031:100:linux backup user:/var/services/homes/rsync:/bin/ash
```

Notice that the last section is a real shell /bin/ash  if it is not a shell you can't log in.

Now you need to modify `/etc/ssh/sshd_config` make sure it has the following lines:-

```
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile  .ssh/authorized_keys
```

Finally you need to create the authorized_keys file in the users account an add a public key to it.
Beware that file permissions are crucial here or ssh will refuse you.

```
su -s /bin/ash rsync
cd $HOME
pwd # make sure you are in /var/services/homes/rsync

mkdir ./.ssh
chmod 700 ./.ssh
touch ./.ssh/authorized_keys
chmod 600 ./.ssh/authorized_keys
```

Then add a public key corresponding to a private key that you own on one line in the file
either use vi an paste it in or from another PC you can use ssh and cat (you'll need to use password for the user until you are done)

Assume my pub key is at ~/.ssh/id_rsa.pub and I want the rsync users authorized_keys file to hold contain that key..

```
ssh rsync@synology "/bin/cat >> ./.ssh/authorized_keys" < ~/.ssh/id_rsa.pub
```

After being prompted for the password the key will be in place.. now restart  synology or quicker just get the ssh daemon to re-read its config

```
synology> ps | grep sshd
16783 root     16772 S    /usr/bin/sshd

synology> kill -HUP 16783
```

You should now be able to ssh to synology as rsync with no password

```
ssh rsync@synology
```

