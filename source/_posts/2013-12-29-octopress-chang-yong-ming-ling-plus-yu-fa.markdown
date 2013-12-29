---
layout: post
title: "Octopress 常用命令+语法"
date: 2013-12-29 13:43
comments: true
categories: Octopress
---
初次使用Octopress，很多语法、命令都容易忘记，所以写下这篇文件给自己做备忘录，同时帮助有需要的人。
***
#命令篇
###1.创建一篇新文章
{%codeblock %}
rake new_post["Octopress 常用命令+语法"]
{%endcodeblock%}
创建后可在`source/_posts/`找到刚刚生成的markdown文件，<br>
文件名字为`2013-12-29-octopress-chang-yong-ming-ling-plus-yu-fa.markdown`。<br>
用text editor打开后可即可编辑。

###2.生成与发布
{%codeblock %}
rake generate
rake deploy
{%endcodeblock%}
*执行以上的两条命令后就成功发布了，但是在github服务器上要一段时间才能显示出来。所以不要以为没成功发布。

###3.本机预览
{%codeblock %}
rake preview
{%endcodeblock%}
你可以通过`localhost:4040`或`127.0.0.1:4040`访问

###4.push源码到github
{%codeblock %}
$ git add .
$ git commit -m '注释之类的..'
$ git push origin source
{%endcodeblock%}
***
#语法篇
其实说白了就是markdown语法，但是我不会。。。
所以要多动手，尝试一下。
###5.代码高亮
如果你想写出像上面一样的代码高亮的框框。

<pre>
{ %codeblock [title] [lang:language] [url] [link text]%}
	some code here.
{ %endcodeblock%}
</pre>

###6.不带行号的代码高亮
使用`<pre></pre>`可得到上面不带行号的高亮。

###7.插入图片、链接
插入图片
<pre>
![图片描述](图片地址) 
</pre>
插入链接
<pre>
[链接描述](链接地址) 
</pre>

###8.令某文字高亮
hello,`hi`,你好

<pre>
hello,`hi`,你好
</pre>

###未完待续
发现好的东西时我会继续添加的，希望帮到有需要的人！<br>
下面推荐一个markdown语法的网站，个人感觉比较全面<br>
[http://wowubuntu.com/markdown/](http://wowubuntu.com/markdown/)

##2014降至，祝大家新年快乐！