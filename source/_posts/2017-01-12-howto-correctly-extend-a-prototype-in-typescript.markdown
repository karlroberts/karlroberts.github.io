---
published: false
layout: post
title: "howto correctly extend a prototype in typescript"
date: 2017-01-12 13:08:31 +1100
comments: true
categories: 
---

beware of need to declare global

exporting from the file makes it a module that breaks relationship from the interface we modify...

need to use this :-

declare global {
    interface Number {
          mod(n:number): number
            }
}

Number.prototype.mod = function (n: number) {
          return ((this % n) + n) % n;
}

let mynum = 13
let foo = mynum.mod(5); //compiles fine


see baserat answer 
https://github.com/Microsoft/TypeScript/issues/8278

see the deepdive book
https://basarat.gitbooks.io/typescript/content/docs/types/lib.d.ts.html
https://basarat.gitbooks.io/typescript/content/docs/project/modules.html



