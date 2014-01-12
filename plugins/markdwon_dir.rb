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
                @@ind = 0       #将@@ind归零
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
                end
                pcontent += content
                dir_str += "</div>"
                if @@ind<1              #判断@@ind是否小于1
                        dir_str = ""    #小于1的话，将dir_str里面的内容清空
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