---
layout: post
title: "iOS7下的斜体中文字"
date: 2014-05-19 10:46
comments: true
categories: 
---
如题, 用遍所有字体都发现不能设置中文斜体, 终于再stackoverflow找到解决办法!

原文连接:[http://stackoverflow.com/questions/21009957/italic-font-not-work-for-chinese-japanese-korean-on-ios-7](http://stackoverflow.com/questions/21009957/italic-font-not-work-for-chinese-japanese-korean-on-ios-7)

{%codeblock lang:objc%}
CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:@"Helvetica-Light matrix:matrix];
textView.font = [UIFont fontWithDescriptor:desc size:17];
{%endcodeblock%}