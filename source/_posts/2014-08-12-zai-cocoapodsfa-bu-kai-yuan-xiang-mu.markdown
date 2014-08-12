---
layout: post
title: "在Cocoapods发布开源项目"
date: 2014-08-12 22:42
comments: true
categories: 
---

##1.前言
最近在项目中需用到一个滚动的的图片浏览控件，由于一直都想尝试一下发布开源的库到cocoapods，所以自己就做了一个然后开始尝试发布到cocoapods。

##2.步骤
###2.1 准备工作
首先，完成自己的项目的库的编写。
然后在目录下运行
{%codeblock lang:bash%}
pod spec create 'YOUR_REPO_NAME'
{%endcodeblock%}
然后就会在目录下创建一个 `YOUR_REPO_NAME.podspec` 文件，接着在文本编辑器中打开如下（已简化，保留有用的，已我的为例）


{%codeblock lang:bash%}
Pod::Spec.new do |s|
  s.name     = 'YYSlideGallery'									#我的开源名字
  s.version  = '0.0.1'											#版本号
  s.author   = { 'ryan' => 'czwen1993@gmail.com' }				#作者信息
  s.homepage = 'https://github.com/czwen1993/YYSlideGallery'	#项目的主页
  s.summary  = 'a gallery'										#项目描述
  s.license  = 'MIT'											#开源项目遵守的协议
  s.source   = { :git => 'https://github.com/czwen1993/YYSlideGallery.git', :tag => s.version.to_s }	#开源项目的资源，版本号一般以tag作为标识
  s.source_files = 'YYSlideGallery/Classes/*.{h,m}'				#开源文件目录
  s.platform = :ios												#平台
  s.ios.deployment_target = '6.0'								#面向的目标
  s.requires_arc = true											#是否需要ARC
end
{%endcodeblock%}

基本的信息就是这些。

###2.2发布到github上
现在，你需要把你的代码发布到github上，同时需要添加`tag`并`push`。

{%codeblock lang:bash%}
git commit -a -m 'commit'
git tag '0.0.1'
git push
git push --tags
{%endcodeblock%}


###2.3发布到cocoapods上
要发布到cocoapods上，你需要一个帐号，可以送个`pod trunk register`命令注册。
{%codeblock lang:bash%}
pod trunk register 'E-mail' 'YOUR_NAME'
{%endcodeblock%}
随后登录你的邮箱验证。


验证后，你就可以发布你的第一个开源库了！

{%codeblock lang:bash%}
pod trunk push '.podspec 文件路径'
{%endcodeblock%}

* 发布前，你可以使用`lint`命令验证一下你的`.podspec`文件是否符合标准。

{%codeblock lang:bash%}
pod spec lint
{%endcodeblock%}

大家晚安！