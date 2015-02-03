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
* plot(t,y) *t,y are vectors*
* `x=[-pi:0.05:-1.8,-1.799:0.001:-1.2,-1.2:0.05:1.2]` *Enlarge some parts and reduce overlap points*
* plotyy(x,y1,x,y2) *multi-Vertical axis graph*, for which has two much different graph.
* polar(theta,rho) *ploar(θ,ρ)*

###Multidimensional Graph
* Implicit Function *ezplot()*`>>ezplot('x^2+y^2-25')`  <==> {{ f1 }}
* `>>plot3(x,y,z)` Parametric equations

###Limit Solving
* L=limit(f,x,x<sub>0</sub>)　　x->x<sub>0</sub>
* L=limit(f,x,x<sub>0</sub>,*'left'or'right'*)　　　Unilateral limit 
* Latex Interprete *latex(f)*

###Derivative
* f1=diff(f,x,n) 

###Symbolic Substitution
* 





