---
layout: post
title: "NSTextView中微博的三种链接检测"
date: 2014-01-14 12:13
comments: true
categories: 
---
前段时间一直在做一个Mac版的微博客户端，但是进度很慢，现在又有别的工作要做。估计要夭折了，并且前几天发现`Weibo For MAC`改名`Weebo`（现在好像是`WeiboX`），我的是`Weeboo`，感觉自己不争气啊，这么长时间都没做好，不能怨别人捷足先登。<br>
现在，我要发布我的第一个demo：在NSTextView中检测微博中`@Ryan坏人`、`#话题#`、`http://czwen1993.github.com` 这三种特殊链接。现已发布在github，心情相当激动！！
##1. 截图
![](../../../../../../postImage/2014-01-14-nstextviewzhong-wei-bo-de-san-chong-lian-jie-jian-ce-ScreenShot.png)
<!--more-->


##2. 工作原理

利用正则表达式匹配`@Ryan坏人`、`#话题#`、`http://czwen1993.github.com`这三种特殊字符串，并返回一个匹配字符的数组。
{%codeblock NSString+FindSomeLinkInText.m lang:objc%}
//扫描链接，返回一个数组
- (NSArray *)scanStringForLinks {
	return [self componentsMatchedByRegex:@"(([http]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))[\\x00-\\xff]"];
}
{%endcodeblock%}
1. 遍历返回的数组，找出在文中所在的位置，并修改属性（颜色、字体之类的）
2. 新的字符串的替换原attributeString中的位置。
{%codeblock AppDelegate.m lang:objc%}
- (void)findSomeLink
    //遍历text，利用正则表达式获取所需的字符串，并存在数组里
    NSArray *linkMatches = [text scanStringForLinks];
    
    //为链接添加属性（颜色、字体……）
    for (NSString *linkMatchedString in linkMatches) {
        NSRange range = [text rangeOfString:linkMatchedString];
        
        if (range.location != NSNotFound) {
            // Add custom attribute of LinkMatch to indicate where our URLs are found. Could be blue
            // or any other color.
            NSDictionary *LinkMatch = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [NSCursor pointingHandCursor], NSCursorAttributeName,
                                      [NSColor blueColor], NSForegroundColorAttributeName,
                                      [NSFont fontWithName:@"Helvetica" size:18], NSFontAttributeName,
                                      linkMatchedString, @"LinkMatch",
                                      nil];
            [attributeString addAttributes:LinkMatch range:range];
        }
    }
}
{%endcodeblock%}
然后再在`-(void)mouseDown:(NSEvent*)event;`中处理点击后的操作

{%codeblock lang:objc%}
-(void)mouseDown:(NSEvent *)theEvent
{
	//获得鼠标位置
    NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    //获取点击的位置在text中的位置
	NSInteger charIndex = [self characterIndexForInsertionAtPoint:point];
    
	//是否在text上点击
	if (NSLocationInRange(charIndex, NSMakeRange(0, [[self string] length])) == YES ) {
		
        //获取点击的字符属性
		NSDictionary *attributes = [[self attributedString] attributesAtIndex:charIndex effectiveRange:NULL];
        
        //处理点击链接后的事件
		if( [attributes objectForKey:@"LinkMatch"] != nil ) {
			NSLog( @"LinkMatch: %@", [attributes objectForKey:@"LinkMatch"] );
            [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:[attributes objectForKey:@"LinkMatch"]]];
		}
	}
	
	[super mouseDown:theEvent];

}

{%endcodeblock%}
##3. 第三方库
本demo运用了[RegexKitLite](http://regexkit.sourceforge.net/),Thank you

##4. 下载

[go to github](https://github.com/czwen1993/3Links-In-Weibo-Text)<br>

update：*现已支持表情的检测*

这是我的第一个demo，也是第一次在github上发布，感谢支持！
