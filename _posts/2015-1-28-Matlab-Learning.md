---
layout: post
title: Matlab Learning
tag: Matlab
---
{% capture f1 %}
<a href="http://www.codecogs.com/eqnedit.php?latex=x^{2}&plus;y^{2}=25" target="_blank"><img src="http://latex.codecogs.com/gif.latex?x^{2}&plus;y^{2}=25" title="x^{2}+y^{2}=25" /></a>
{% endcapture %}
##Matrix
Empty Matrix: a=[];
##plot
###Two-Dementional Graph
* plot(t,y) *t,y are 1×n vectors*
* 如果我们想让函数急剧变化部分采样点比平缓部分更多，可以将x矩阵分段写`x=[-pi:0.05:-1.8,-1.799:0.001:-1.2,-1.2:0.05:1.2]` *Enlarge some parts and reduce overlap points*
* plotyy(x,y1,x,y2) *multi-Vertical axis graph*, for which has two much different graph.
* polar(theta,rho) *ploar(θ,ρ)*
* 图例(legend) *Usage* `legend('Sample','True Value','Sim Result');`
* X轴，y轴标签，`Xlabel('xlabelname');` `ylabel(ylabelname):`
* At the upper left corner of the figure window, you can click *File->Save As* and save image as .jpg. 
![savejpg](\assets\images\2015-01-28\savejpg.jpg)

###Multidimensional Graph
* Implicit Function *ezplot()*`>>ezplot('x^2+y^2-25')`  <==> {{ f1 }}
* `>>plot3(x,y,z)` Parametric equations

###Limit Solving
* L=limit(f,x,x<sub>0</sub>)　　x->x<sub>0</sub>
* L=limit(f,x,x<sub>0</sub>,*'left'or'right'*)　　　Unilateral limit 
* Latex Interprete *latex(f)*

###Derivative
* f1=diff(f,x,n) 

###Grid data


####平面网格坐标矩阵的生成

当绘制z=f(x,y)所代表的三维曲面图时，先要在xy平面选定一矩形区域，假定矩形区域为D＝[a,b]×[c,d]，然后将[a,b]在x方向分成m份，将[c,d]在y方向分成n份，由各划分点做平行轴的直线，把区域D分成m×n个小矩形。生成代表每一个小矩形顶点坐标的平面网格坐标矩阵，最后利用有关函数绘图。

[X,Y]=meshgrid(xvector,yvector)

例子：[X,Y]=meshgrid(-3:0.6:3,-2:0.4:2).xvector长度为N，即把[a,b]分成了N份，yvector长度为M，即把[c,d]分成了M份。那么得到的X和Y的大小都为M×N（M行N列)

####reshape函数

reshape把指定的矩阵改变形状，但是元素个数不变，

例如，行向量：
a = [1 2 3 4 5 6]

执行下面语句把它变成3行2列：
b = reshape(a,3,2)

执行结果：
b =<br/>
1 4<br/>
2 5<br/>
3 6

若a=[<br/>1 2 3<br/>4 5 6<br/>7 8 9<br/>]

*因为matlab使用列优先原则*

使用reshpe后想得到b=[1 2 3 4 5 6 7 8 9]
只需要将a转置一下就可以了：
b=reshape(a',1,9)

###Symbolic Substitution








