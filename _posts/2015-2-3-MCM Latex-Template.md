---
layout: post
title: 美赛(MCM)模板配置及简要Latex语法介绍
tag: MCM
---
##排版系统-Latex介绍
LaTeX，是一种基于TEX的高质量排版系统。它有为科学技术类文献的排版而量身定做的功能。利用这种格式，即使用户没有排版和程序设计的知识也可以充分发挥由TEX所提供的强大功能，能在几天，甚至几小时内生成很多具有书籍质量的印刷品。对于生成复杂表格和数学公式，这一点表现得尤为突出。因此它非常适用于生成高印刷质量的科技和数学类文档。

*LaTeX不是文字处理器。* 恰恰相反，LaTex鼓励作者去不要过多担心他们写的文档的外观和样式，而是专注于先排好文档的内容。正式基于这种*内容和样式的分离*的理念，LaTex系统把文档内容的设计外包给了专门的设计人员，而让作者的工作重心回到写作上。

所以，LaTex的样式看上去是这样。

![LaTex-code](\assets\images\2015-2-3\LaTex-code.png)

##Windows 配置环境

###**Miktex** [下载地址](http://miktex.org/download)
 
Miktex是一种Microsoft Windows系统上运行的文字处理系统。

MiKTeX包含了TeX及其相关程序，提供了文字处理所需的工具，这些工具是以TeX/LaTeX标志语言所构成的。而MiKTeX上提供一个简易的文本编辑器：TeXworks（不推荐）。

MiKTeX的安装程序相当容易。MiKTeX的升级可借由下载新的代码与宏包完成，可以用自带的Package Manager，也可以手动解压（手动比较麻烦）。

###**Winedt** [下载地址](http://www.winedt.com/download.html)

WinEdt是一款Microsoft Windows平台下的文本编辑器。它主要是用来创建TeX（或者LaTeX）文档，但是同时也能处理HTML或者其他文本文档。它被很多TeX系统如MiKTeX，fpTeX和TeX Live用来当作输入前端。

Miktex和Winedt全都安装完成之后，就可以开始文档编写了。
编译快捷键`Ctrl+Shift+P`

[美赛论文模板下载](\files\mcmthesis.zip)

##LaTex语法

###LaTeX文件的通常语法如下：

!(LaTex-code)[\assets\images\2015-2-3\LaTex-code.png]

*这就是一个完整的文件了*

### 简单的规则：

1. 空格。同markdown语法一样，*有空格和没空格*有区别*的，几个空格和一个空格是*没区别*的。
2. 换行。用命令`\\` 或者 `\newline`
3. 分段。用命令`\par`或`clearpage`
4. 特殊字符`#，$, %, &, - ,{, }, ^, ~` 要输出分别用`\#` `\$` `\%` `\&` `\-` `\{` `\}` `\^{}` 输出左上角波浪线`\^{}`,左边中间波浪线`$\sim$`,右边的字母上方波浪线`\~`,
 `$backslash$` 表示反斜杠 `\`

###数学公式排版

[英文文献](http://www.personal.ceu.hu/tex/math.htm)

LaTex有3种数学环境模式：math，displaymath和equation。

* Math. 数学公式插在前文的左边，命令为 `$...$`或`\[...\]`或`\begin{math}...\end{math}`。
* displaymath. 数学公式另起一行居中，命令为`$$...$$`或`\(...\)`或`\begin{displaymath}...\end{displaymath}`。
* equation。数学公式另起一行居中并在最右边有公式的序号，命令为`\begin{equation}...\end{equation}`

数学公式输入

[图形化编辑地址](http://www.codecogs.com/latex/eqneditor.php)
* 上标`^{}`
* 下标`_{}`
* 分数`frac{分子}{分母}`
* <,> 直接打。 ≥ `\geq`，≤ `\leq`。
* 上划线 `\overline{}`，下划线`\underline{}`
* Σ `sum_{a}^{b}` 下a上b

先就整理这么多，美赛结束后补。

推荐资料：

[Texbook](\files\texbook.pdf)

LaTex 的作者 D. E. Knuth 的 TeXbook. 这当然是最权威的读物了。无论什么时候这本书都是 TeX 语言规则的最终参考。它对Tex语言的每一个细节和工作原理都有详细的介绍。

这本书确实不是给一个初学者或者纯LaTeX使用者看的。但如果你想深入了解Tex引擎的工作原理，那么迟早你会读到这本书。

[TeXbyTopic](\files\TeXbyTopic.pdf)

如果你想稍微了解一下Tex工作原理，那先从这本书看起吧。
比上面的Texbook相对好懂一点。

[LatexCommandSummary.pdf](\files\LatexCommandSummary.pdf)

14页的LaTeX命令速查手册，可以备一本电子书或者打印一份放在手边备用。






