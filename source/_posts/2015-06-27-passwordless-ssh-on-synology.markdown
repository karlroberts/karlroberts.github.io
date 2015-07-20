---
layout: post
title: "passwordless ssh on synology"
date: 2015-06-27 17:43:13 +1000
comments: true
published: false
categories: 
- ssh
- passwordless
- synology
---

I want the rsync user on my synology box (called synology) to use ssh with no password.

first I create the ssh key

```
ssh-keygen -t dsa
```

when asked for the password for the key simply hit `enter` key, and again.
This will create a private key an dpublic key in 

```
~/.ssh/id_dsa
~/.ssh/id_dsa.pub
```

Over on the Synology box (I assume you have ssh'd there as root)

```
ssh root@synology
```

some hoops nee to be jumped.

by default you can't get to the home dir of a user, it is mapped to a fake place
Get around that by:-

* go to Users admin page
  - click advanced 
  - turn on "home services"

mow you need to modify the home dir permissions

```
cd /var/services/homes

chmod 755 user user # by default synology setts 777 and sshd is picky
```

now you need to actually give your user a shell. 
as root edit `/etc/passwd`

you need an entry like

```
rsync:x:1031:100:linux backup user:/var/services/homes/rsync:/bin/ash
```

notice that the last section is a real shell /bin/ash  if it is not a shell you can't log in.

Now you need to modify `/etc/ssh/sshd_config` make sure it has the following lines:-

```
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile  .ssh/authorized_keys
```

finally you need to create the authorized_keys file in the users account an add a public key to it.
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

then add a public key corresponding to a private key that you own on one line in the file
either use vi an paste it in or from anoer PC you can use ssh and cat (you'll need to use password for the user until you is done)

assume my pub key is at ~/.ssh/id_dsa.pub and I want the rsync users authorized_keys file to hold contain that key..

```
ssh rsync@synology "/bin/cat >> ./.ssh/authorized_keys" < ~/.ssh/id_dsa.pub
```

after being prompted for the password the key will be in place.. now restart  synology or quicker just get the ssh deamon to re-read its config

```
synology> ps | grep sshd
16783 root     16772 S    /usr/bin/sshd

synology> kill -HUP 16783
```

you should now be able to ssh to synology as rsync with no password

```
ssh rsync@synology
```

