---
layout: post
title: Linux Shell 参数选项解析
tag: Bash
---

###需求
接上一篇博客，现在我们有这几个问题，

* 我们要把 git push 和 jekyll s 结合起来，这就要求我们传入参数。
* 还发现了一个bug，如果简简单单地{% highlight Bash %}sed -i 's/highlighter: rouge/# highlighter: rouge/g' exp.yml{% endhighlight %}当同样的命令运行多次后，效果就是{% highlight Bash %}# # # # # # # # # # # # # # highlighter: rouge{% endhighlight %}* 这就要求我们搜索字符串。这里我用了整行替换，如果该行有pygments关键字则整行替换为highligt: pygments。（虽然不够严密，但是现在够用了，反正_config.yml 后面没有出现过rouge关键字）

#### 小小地吐槽一下
在pygment和rouge下Linux Shell 代码的时候要使用

![highlightBash](\assets\images\2015-02-18\highlightBash.jpg)

否则会造成Github Page 的编译错误

[pygments支持的语言](http://pygments.org/languages/)

####传入参数

这里我使用位置参数，position parameters。从命令行里传进来的参数，$0,$1,$2...$0代表脚本名，$1是第一个参数，$2是第二个参数...以此类推
[source](http://linuxcommand.org/wss0130.php)


可以用这段代码测试，

{% highlight Bash %}
#!/bin/bash

echo "Positional Parameters"
echo '$0 = ' $0
echo '$1 = ' $1
echo '$2 = ' $2
echo '$3 = ' $3
{% endhighlight %}

一般的小脚本我们可以用手动处理，$1,$2,$3来设置参数，但是既然是学习，我们就要挖得深点，现在我们来学习sh中选项的使用，用shell自带的getopts来解析选项和参数。

* 参数和选项的区别

{% highlight Bash %}
shell_name para1 para2 para3 #这是参数，用 $0,$1,$2...调用

shell_name -d para -v   #-d是选项，后面可以加参数，也可以不加，如果不加，称为开关选项，参数值为true或false
{% endhighlight %}
[source](http://my.oschina.net/leejun2005/blog/202376)

{% highlight Bash %}
#!/bin/bash
echo 初始 OPTIND: $OPTIND
 
while getopts "a:b:c" arg #选项后面的冒号表示该选项需要参数
do
    case $arg in
        a)
            echo "a's arg:$OPTARG" #参数存在$OPTARG中
            ;;
        b)
            echo "b's arg:$OPTARG"
            ;;
        c)
            echo "c's arg:$OPTARG"
            ;;
        ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
            exit 1
        ;;
    esac
done
 
echo 处理完参数后的 OPTIND：$OPTIND
echo 移除已处理参数个数：$((OPTIND-1))
shift $((OPTIND-1))
echo 参数索引位置：$OPTIND
echo 准备处理余下的参数：
echo "Other Params: $@"
{% endhighlight %}

####修复上次的bug
如果简简单单地{% highlight Bash %}sed -i 's/highlighter: rouge/# highlighter: rouge/g' exp.yml{% endhighlight %}当同样的命令运行多次后，效果就是{% highlight Bash %}# # # # # # # # # # # # # # highlighter: rouge{% endhighlight %}* 这就要求我们搜索字符串。这里我用了grep整行替换，如果该行有pygments关键字则整行替换为highligt: pygments。（虽然不够严密，但是现在够用了，反正_config.yml 后面没有出现过rouge关键字）

[grep函数用法](http://www.lampweb.org/linux/3/27.html)

{% highlight Bash %}
antiCommentString="s/"`grep pygments exp.yml`"/highlighter: pygments/g"
commentString="s/"`grep rouge exp.yml`"/# highlighter: rouge/g"
			
sed -i "$antiCommentString" exp.yml
sed -i "$commentString" exp.yml
{% endhighlight %}

###最终成果

[code here](https://github.com/ZhuFengdaaa/ZhuFengdaaa.github.io/blob/master/PushorPreview.sh)