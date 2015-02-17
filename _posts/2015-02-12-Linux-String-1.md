---
layout: post
title: Linux Bash 简单字符串处理
tag: Bash
---

###需求
* 维护Jekyll博客的时候，本地预览每次都要打命令`jekyll s`
* 每次push 到 github上时，我们都要写一串命令`git add --all`，`git commit -m <message>`，`git push`。特别繁琐。
* 我们可以在平时的小修改中用*日期-时间*来作为commit的message
* 由于Github不兼容代码高亮插件rouge，push到远程的时候我们只能用pygments作为代码高亮插件，这没啥。但苦逼的是，由于windows与pygments不兼容，我们在本地预览只能用rouge。所以我们要经常切换

[高亮问题在Github一直没解决 ╮(╯▽╰)╭，我也是在 Github 上看到的临时办法 ](https://github.com/jekyll/jekyll/issues/2789)

###任务
* 我们设计一个Bash小程序，来完成上述的*命令自动输入*和*字符串切换*

我们先来预习基本知识

-------

####字符串的删改

[Tutorial](http://www.cyberciti.biz/faq/unix-linux-replace-string-words-in-many-files/)

{% highlight Bash %}
sed -i 's/new string/old string/g' *.txt
{% endhighlight %}

####从键盘读取变量

{% highlight Bash %}
read variable
{% endhighlight %}

####去掉前缀空格

[Reference Source](http://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-bash-variable)

{% highlight Bash %}
input="$input" | sed 's/^ *//'
或
input="$input" | sed 's/^[ \t]*//'
{% endhighlight %}
在这里，

* `s/ `: 替换命令，替换每行中被`^[ \t]`匹配到的部分
* `^[ \t]*` : 搜索匹配 ( ^ 指每行的开头开始; [ \t]* 匹配包括缩进在内的一串空格)
* `//` : 删掉所有匹配项

####判断字符串是否为空

三种写法
{% highlight Bash %}
if [ -z "$str" ]; then
   echo "Str is null"
fi
或
if [ "$str" == "" ];then
   echo "Str is null"
fi
或
if [ ! "$str" ];then
   echo "Str is null"
fi
{% endhighlight %}

####将当前日期作为commit message
如果读入了一个空串（即输入全是空格或者只有回车，read函数返回一个空串，
有点像c语言里的std::cin）那么我们就把当前时间作为commit message。

{% highlight Bash %}
input=`date +%Y-%m-%d-%H-%M-%S`
{% endhighlight %}

注：shell在赋值的时候变量前不加`$`，而在引用的时候变量前加`$`作为标识符。
{% highlight Bash %}
`date +%Y-%m-%d-%H-%M-%S` 
{% endhighlight %}
是执行 shell 下的 date 命令，%Y,%m,%d,都是命令 date 的参数，分别对应年月日时分秒。左右加 ` 表示中间执行的是shell命令（否则将 date +%Y-%m-%d-%H-%M-%S 作为字符串处理。将返回值赋给input。

附上最终代码

{% highlight Bash %}
sed -i 's/# highlighter: pygments/highlighter: pygments/g' _config.yml
sed -i 's/highlighter: rouge/# highlighter: rouge/g' _config.yml
echo 'Input commit message:'
read input

if [ "$input" == "" ]; then
        input=`date +%Y-%m-%d-%H-%M-%S`
fi

git add --all
git commit -m "$input"
git push
{% endhighlight %}