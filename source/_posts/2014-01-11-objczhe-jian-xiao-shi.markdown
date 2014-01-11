---
layout: post
title: "Objc这件小事"
date: 2014-01-11 15:03
comments: true
categories: 
---
###目录
1. NSMutableData


<!--more-->
---
###1. NSMutableData
`NSMutableData`的各种操作，添加、清空数据
{%codeblock lang:objc%}
NSMutableData *mdata = [NSMutableData alloc]init];
//添加数据
[mdata appendData:data];
//清空数据
[mdata setLength:0];
{%endcodeblock%}
