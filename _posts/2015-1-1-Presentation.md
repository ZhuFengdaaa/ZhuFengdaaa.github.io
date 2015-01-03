---
layout: post
title: Presentation
tag: Jekyll
---

Usage:
{{ page.my-costom-statement }}

yaml header -> for mata data (costom statement自定义状态)

page（页面） <- layout（样式） <- include(组件）

Templates + Contents --(jekyll)---> static pages --(upload to server )---> get website 

Why I choose Jekyll?

1. Faster site
2. More secure
3. Less Manipulate
4. Lower cost
5. Free hosting on Github
6. Blog aware
7. Markdown ready

##Directory Structure（jekyll 的目录结构）

**（惨痛的教训，自定义的文件夹名不能以`_`打头）**

![jekyll-structure]({{ site.baseurl }}/assets/images/post-Presentation/jekyll-structure.png)			

###让我来解释一下：
1. 侧边栏的制作
2. 						

##jekyll Meto improving
1. Add sidebar background-color effect
2. Add "search"column into the sidebar
3. "page" and "post" layout modify.*content-wrapper col-md-10 -> col-md-9; col-sm-10 -> col-sm-9*. Set the left margin. 
4. Add SVG button into the footer.html footer-link into the config.yml
