---
layout: post
title: "Objc这件小事"
date: 2014-01-11 15:03
comments: true
categories: Objc
---

##前言
Objc各种小杂物，虽然微不足道，但是用起来可以在这里翻查一下。


<!--more-->
---
##1. NSMutableData
`NSMutableData`的各种操作，添加、清空数据
{%codeblock lang:objc%}
NSMutableData *mdata = [NSMutableData alloc]init];
//添加数据
[mdata appendData:data];
//清空数据
[mdata setLength:0];
{%endcodeblock%}
