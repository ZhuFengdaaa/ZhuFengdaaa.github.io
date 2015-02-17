---
layout: post
title: Linux Shell 简单字符串处理
tag: Shell
---

###需求
* 维护Jekyll博客的时候，本地预览每次都要打命令`jekyll s`
* 每次push 到 github上时，我们都要写一串命令`git add --all`，`git commit -m <message>`，`git push`。特别繁琐。
* 我们可以在平时的小修改中用*日期-时间*来作为commit的message
* 由于Github不兼容代码高亮插件rouge，push到远程的时候我们只能用pygments作为代码高亮插件，这没啥。但苦逼的是，由于windows与pygments不兼容，我们在本地预览只能用rouge。所以我们要经常切换

[高亮问题在Github一直没解决 ╮(╯▽╰)╭，我也是在stackoverflow上看到的临时办法 ](https://github.com/jekyll/jekyll/issues/2789)

###任务
* 我们设计一个bash小程序，来完成上述的*命令自动输入*和*字符串切换*

我们先来预习基本知识

