---
layout: post
title: "iOS本地化的小问题"
date: 2014-08-04 23:15
comments: true
categories: 
---
好久无写过文章了，今天做iOS本地化遇到点小问题，在这里给大家分享一下和做个笔记。
##1. 应用名称本地化
首先新建一个InfoPlist.strings，然后添加所需的语言


![](../../../../../../postImage/Screen-Shot 2014-08-04-at 11.22.59-PM.png)


接着在每个语言的`InfoPlist.strings`中添加
{%codeblock lang:objc%}
CFBundleDisplayName="Your app name";
{%endcodeblock%}
最后，在Info.plist添加`Application has localized display name`字段，类型为`Boolean`，并设为`YES`


![](../../../../../../postImage/Screen-Shot 2014-08-04-at 11.22.26-PM.png)


##2. 应用内容本地化
如果遇到设置base语言之后不生效，可以尝试用en作为默认语言：
{%codeblock main.m lang:objc%}
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 使设置生效
        
    // 使en总是在第二位，第一位找不到就用第二位的
    NSMutableArray *mutableLanguages = [[NSLocale preferredLanguages] mutableCopy];
    NSInteger enIndex = NSNotFound;
    for (NSString *lang in mutableLanguages) {
        if ([lang isEqualToString:@"en"])
        {
            enIndex = [mutableLanguages indexOfObject:lang]; break;
        }
    }
    @try
    {
        if ((enIndex != 0) && (enIndex != 1)) {
            [mutableLanguages exchangeObjectAtIndex:1 withObjectAtIndex:enIndex];
        }
    } @catch (NSException *exception) {
        
    }
    // 保存设置
    [[NSUserDefaults standardUserDefaults] setObject:mutableLanguages forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 使设置生效
{%endcodeblock%}

以上代码插在 main.m return前。

NSLog(@"good night world!")