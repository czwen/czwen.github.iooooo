---
layout: post
title: "CocoaPods安装与使用"
date: 2014-02-28 09:58
comments: true
categories: XCode CocoaPods
---
##前言
在开发App中难免遇到用第三方类库的情况，CocoaPods就是一款很好管理第三方类库的工具。在没有CocoaPods之前，使用第三方类库需要进行繁琐的操作，把库下载下来、解压、拉入project、配置参数……
但是CocoaPods将简化以上操作并为更新类库带来便利。
***
##安装
准备功夫：
<ol>
<li>建议先把ruby更新至最新版本</li>
<li>由于国情原因，rubygems.org放在AWS的资源会被墙，所以先把ruby的源换成国内的https://rubygems.org/</li>
</ol>
↓
{%codeblock lang:bash%}
/*更新ruby至最新*/
sudo gem update --system

/*更新ruby源*/
gem sources --remove https://rubygems.org/
gem sources -a http://ruby.taobao.org/
gem sources -l
{% endcodeblock %}

现在，应该不会处什么差错了。安装方式非常简单，使用ruby的gem命令即可下载安装：↓
{%codeblock lang:bash%}
sudo gem install cocoapods
pod setup
{%endcodeblock%}
注意：执行至第二`pod setup`时，会输出Setting up CocoaPods master repo，这部时间较长，其实是Cocoapods下载其信息，大概120+MB，你可以查看文件大小来看是否在继续下载而不是卡死了。↓
{%codeblock lang:bash%}
cd ~/.cocoapods
du -sh *
{%endcodeblock%}

至此，你的CocoaPods已经安装完成。
***
##使用
首先，你需要新建一个名为Podfile的文件↓
{%codeblock lang:bash%}
cd "your project home"
touch Podfile
{%endcodeblock%}

然后，你可以用Sublime Text之类的editor编辑Podfile，格式如下↓
{%codeblock%}
platform :ios, '7.0'
pod "AFNetworking", "~> 2.0"
{%endcodeblock%}

保存

最后，执行以下命令
{%codeblock lang:bash%}
pod install
{%endcodeblock%}

大功告成！现在，你的第三方库已经准备好了。
不过还需注意以下两点：
<ol>
<li>使用CocoaPods生成的 .xcworkspace 文件来打开工程，而不是以前的 .xcodeproj 文件。</li>
<li>每次更改了Podfile文件，你需要重新执行一次pod install命令。</li>
</ol>

***

现在，你只需要安装CocoaPods（一次）、在project目录下建立Podfile文件、配置Podfile文件、然后进行`pod install`的操作，你所需要的第三方类库就会自动加入。

参考博文：

[http://blog.devtang.com/blog/2012/12/02/use-cocoapod-to-manage-ios-lib-dependency/](http://blog.devtang.com/blog/2012/12/02/use-cocoapod-to-manage-ios-lib-dependency/)

Have fun~


