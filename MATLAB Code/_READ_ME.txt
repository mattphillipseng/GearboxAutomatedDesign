MATTHEW PHILLIPS - DECEMBER 7TH, 2017

There are two main things that should be run:
-gearratios.m
-graphstress.m

Open the files in MATLAB and make sure matlab's current path is set to the directory in which the scripts are stored.

OUR CODE ASSUME SAME MODULE FOR ALL GEARS

------------------------------------------------------------------------
In MATLAB's command line, type:

gearratios()

to run the gearratios.m script

can change the module in the code on line 8
------------------------------------------------------------------------




------------------------------------------------------------------------
To reset everything, type:

clear [press enter key]
clc [press enter key]
------------------------------------------------------------------------




------------------------------------------------------------------------
To generate the F-m plots, type:

graphstres(18,45,20,64,'b');


Make sure not to forget the semicolon or it will take much longer!

'b' to get contourf plots
'a' to get 3D plots

Numbers of teeth are input for G2,G3,G4,G5 in that order
Other teeth combinations can be input as well, for example:

graphstress(20,36,22,60);

CAN CHANGE RESOLUTION OF PLOTS ON LINE 47
------------------------------------------------------------------------




------------------------------------------------------------------------
To reset everything, type:

clear [press enter key]
clc [press enter key]
------------------------------------------------------------------------







