---
layout: page
title: "installing phonegap"
date: 2014-07-03 15:59
comments: true
sharing: true
footer: true
---
Phone gap allows you to dev a simple HTML5/CSS/JS app and deploy the same webapp in a phone.
The app runs as a WebView, but has access to underlying device api's via plugins.

The trick is that you do your html5/JS app AND build the deployable which mixes in the platform specific plugins and libs that allow the magic to happen.

once done you can create a app like this:-
    $ cordova create hello com.example.hello HelloWorld

and add particular platforms like Ubuntu or Android or IOS. like this
    $ cordova platform add ios
    $ cordova platform add amazon-fireos
    $ cordova platform add android
    $ cordova platform add blackberry10
    $ cordova platform add firefoxos

The thing that may mess you up is that you need to install the various platform SDK's first, so to develop UBUNTU widgets:-
on ubuntu do : [this](http://developer.ubuntu.com/start/ubuntu-sdk/installing-the-sdk/)

For android install the Android SDK
* download the adt zip file from [here](http://developer.android.com/sdk/index.html#download)
* unzip it somewhere eg `$HOME/android-sdk`
* set up your PATH as described [here](http://docs.phonegap.com/en/edge/guide_platforms_android_index.md.html#Android%20Platform%20Guide) 
  - put this in your .bashrc file:-  `export PATH=${PATH}:/$HOME/android-sdk/sdk/platform-tools:/$HOME/android-sdk/adt-bundle/sdk/tools`
  - `source ~/.bashrc`
    [robertk@Katana hello]$ cordova platform add android
    Creating android project...

    /home/robertk/.cordova/lib/android/cordova/3.5.0/bin/node_modules/q/q.js:126
                        throw e;
                              ^
    Error: Please install Android target 19 (the Android newest SDK). Make sure you have the latest Android tools installed as well. Run "android" from your command-line to install/update any missing SDKs or tools.
      at /home/robertk/.cordova/lib/android/cordova/3.5.0/bin/lib/check_reqs.js:80:29
      at _fulfilled (/home/robertk/.cordova/lib/android/cordova/3.5.0/bin/node_modules/q/q.js:798:54)
      at self.promiseDispatch.done (/home/robertk/.cordova/lib/android/cordova/3.5.0/bin/node_modules/q/q.js:827:30)
      at Promise.promise.promiseDispatch (/home/robertk/.cordova/lib/android/cordova/3.5.0/bin/node_modules/q/q.js:760:13)
      at /home/robertk/.cordova/lib/android/cordova/3.5.0/bin/node_modules/q/q.js:574:44
      at flush (/home/robertk/.cordova/lib/android/cordova/3.5.0/bin/node_modules/q/q.js:108:17)
      at process._tickCallback (node.js:415:13)
    Error: /home/robertk/.cordova/lib/android/cordova/3.5.0/bin/create: Command failed with exit code 8
      at ChildProcess.whenDone (/usr/share/cordova-cli/_vendor/cordova-lib/0.21.3/src/cordova/superspawn.js:131:23)
      at ChildProcess.EventEmitter.emit (events.js:98:17)
      at maybeClose (child_process.js:743:16)
      at Process.ChildProcess._handle.onexit (child_process.js:810:5)
  - This shows that we need android version 19

* Once youve installed the sdk running `cordova platform add android` will now work

