model_analyser
==============

This R script can be used to analyse and select the best
homologie model made by Modeller.

It will create a new folder called Best_Model with the
best modeller model inside.

The selection is made on the Objective Function Score 
(the lowest value is the best).

it also create a pdb graph called obj_graph.pdf

Simply run : 
Rscript Analyse_best.R [NAME]
with name corresponding to the modeller project name.
Ex : with files like "NB2.B99990001.pdb", your have to run
Rscript Analyse_best.R NB2

PLEASE NOTE:
I used terminal coloring for all name in prompt. This coloration
is specific to Linux and will not work on MAC.
