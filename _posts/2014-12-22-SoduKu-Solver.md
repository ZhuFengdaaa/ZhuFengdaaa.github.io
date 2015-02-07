---
layout: post
title: SoduKu Solver
---

[**Responsory Link**](https://github.com/ZhuFengdaaa/SoduKu-Solver)

![SudoKu-solver]({{ site.baseurl }}/assets/images/SoduKu-Solver.png )

A fairly simple SuduKu-Solver written in Java, which I had finished with my teammate off and on for a week.
	
##How to run

just Download ZIP and import it into your eclipse IDE.Compile and Click Run. _Done._ 

## Read data
It expects a partially solved Sudoku board. It has written already.(One thing we may want to develop is to create a Graphic 
UI;)

#Problem Solving

*A genetic algorithm is a general way to solve optimization problems. The basic algorithm is very simple:*

1. Create a population (vector) of random solutions (represented in a problem specific way, but often a vector of floats or ints)
2. **Do Evolution** until the answer we want exist,
which means we should pick a few parent to generate next generation.*until next generation's population is large enough.*
3. Replace the old generation with a new generation, which is either a copy of the best solution, a mutation (perturbation) of the best solution, an entirely new randomized solution or a cross between the two best solutions. These are the most common evolutionary operators, but you could dream up others that use information from existing solutions to create new potentially good solutions.
4. Check if you have a new global best fitness, if so, store the solution.
5. Go to 2

###warning
If too many iterations go by without improvement, the entire population might be stuck in a local minimum (at the bottom of a local valley, with a possible chasm somewhere else, so to speak). If so, kill everyone and start over at 1.

###More details
[Reference Link:](http://fendrich.se/blog/2010/05/05/solving-sudoku-with-genetic-algorithms/ "Reference Link")

[Chinese Documentation Download](https://github.com/ZhuFengdaaa/SoduKu-Solver/raw/master/%E9%81%97%E4%BC%A0%E7%AE%97%E6%B3%95%E6%B1%82%E8%A7%A3%E4%B9%9D%E5%AE%AB%E6%A0%BC%E6%95%B0%E7%8B%AC.docx)

[应急物流网络规划方法研究](\files\Note\001.pdf)