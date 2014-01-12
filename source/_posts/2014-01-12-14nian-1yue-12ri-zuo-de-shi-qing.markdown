---
layout: post
title: "14年1月12日做的事情"
date: 2014-01-12 15:52
comments: true
categories: Octopress duoshuo 
---
两天的小假期，今天没有做ios开发，玩了一下Octopress，解决了困扰已久的bug，和加上了自动生成文章目录的功能和改进了一点小不足。
<!--more-->
##1. 解决页面CSS丢失
应该是多说某些代码与Octopress本身的代码有冲突，通过查看页面的源码发现`<head></head>`内的`description`部分出现了错乱。接着我把`/source/_includes/head.html`里面的`{ %capture description%}`部分注释掉，总算解决。

##2. 为文章加上自动目录
作者是[http://c4fun.cn/](http://c4fun.cn/blog/2013/11/24/octopress-generate-post-content/)做的一个小插件。<br>
用着发现：当文章里面没有`##`的小标题时仍然会出现一个<pre>###目录</pre>
这样一个有轻微强迫症的人很不爽。。。

SO，diy一下。`14` `25` `30-32`行（PS:codeblock里面的mark好像用不了，可能是GreyShade这个theme问题吧 ?_? ）
{%codeblock MardowndirFilter.rb lang:ruby %}
# MardowndirFilter.rb
# Add content for each post 
# swm8023 c4fun.cn
# 11.24.2013
#
require './plugins/post_filters'

module MarkdowndirFilter
        @@ind = 0
        def generatedir(post)
                content = post.content;
                dir_str = "<div id='markdir'><p><strong>目录</strong></p>";
                pcontent = ""
                count = 0;      #count用作记着###的数目
                while md = /<h(\d)>(.*?)<\/h\d>/.match(content) do
                        # puts md[0];
                        content = md.post_match
                        pcontent += md.pre_match + "<span id =\"markdir#{@@ind}\"></span>"+md[0]
                        hx = Integer(md[1])
                        dir_name = md[2]
                        dir_name = md[1] if md = /<strong>(.*?)<\/strong>/.match(dir_name)
                        dir_str += "&nbsp;&nbsp;&nbsp;&nbsp;" while (hx = hx - 1) > 0
                        dir_str += "<a href=\"#markdir#{@@ind}\">" + dir_name +"</a><br/>"
                        @@ind = @@ind + 1
                        count = @@ind      #记录@@ind的值
                end
                pcontent += content
                dir_str += "</div>"

                if count<1              #判断count是否小于1
                        dir_str = ""    #小于1的话，讲dir_str里面的内容清空
                end
                #puts dir_str
                dir_str + pcontent
        end
end

module Jekyll
        class Markdowndir < PostFilter
                include MarkdowndirFilter
                def post_render(post)
                        post.content = generatedir(post) if post.is_post?
                end
        end
end

Liquid::Template.register_filter MarkdowndirFilter
{%endcodeblock%}

😎在完全没有ruby的情况下做出来了，本来打算直接这样的：
{%codeblock lang:ruby%}
if @ind<1
	dir_str = ""
end
{%endcodeblock%}
但是出错，唯有加一个变量了。
<br>
感觉Ruby还是一门值得学习的语言，很简洁地说！
##3. 多说获取文章标题
<pre>
data-title="{ {page.title}}"
</pre>
*去掉空格，不加双引号的话，当标题有空格就会断掉。