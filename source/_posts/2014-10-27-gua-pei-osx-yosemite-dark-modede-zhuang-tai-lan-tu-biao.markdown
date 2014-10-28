---
layout: post
title: "适配OSX Yosemite Dark Mode的状态栏图标"
date: 2014-10-27 11:30
comments: true
categories: 
---
##前言
OSX 10.10 Yosemite 增加了一个Dark Mode，使状态了个Dock呈现黑色的风格，打开方法：`设置->通用->勾选“使用暗色菜单栏和Dock”`，这使在菜单栏有应用图标的App增加适应Dark Mode

##截图
![](../../../../../../postImage/Screen Shot 2014-10-27 at 2.52.52 PM.png)
![](../../../../../../postImage/Screen Shot 2014-10-27 at 2.53.05 PM.png)
<!--more-->

##代码
``` objc
NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];

id style = [dict objectForKey:@"AppleInterfaceStyle"];

BOOL darkModeOn = ( style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"] );

if(darkModeOn){
	// do something in darkModeOn
}else {
	// do something in lightModeOn
}
```

最好还需要增加一个通知，来获取用户切换dark mode，

``` objc
[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(darkModeChanged:) name:@"AppleInterfaceThemeChangedNotification" object:nil];
```



但是，今天又找到一个更好的办法，Apple官方推荐的办法。
``` objc
NSImage *image = [NSImage imageNamed:@"track_light"];
[image setTemplate:YES];	
[self.statusBarButton setImage:image];
[self.statusBarButton setAlternateImage:image];
```

这样就不用再设置通知，也不用判断是什么模式。这个办法更为简洁，赞！

如果是要支持旧版本，应该再判断一下再`setTemplate`
```
BOOL isOldSystem = (floor(NSAppKitVersionNumber) <= NSAppKitVersionNumber10_9);
```


