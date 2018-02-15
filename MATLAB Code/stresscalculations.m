function [bending2, bending3, bending4, bending5, surf2, surf3, surf4 ,surf5] = stresscalculations(n2, n3, n4, n5, m, F)



%Calc G2: input pinion
    RPM_n2 = 4000; %PINION RPM
    bending2 = bendingstress(m,F,n2,n3,RPM_n2,'p');
    surf2 = surfacestress(m,F,n2,n3,RPM_n2,'p'); 

%Calc G3: stage 1 gear
    RPM_n3 = 4000; %PINION RPM
    bending3 = bendingstress(m,F,n2,n3,RPM_n3,'g');
    surf3 = surfacestress(m,F,n2,n3,RPM_n3,'g');

%Calc G4: stage 2 pinion
    RPM_n4 = 4000*(n2/n3); %PINION RPM
    bending4 = bendingstress(m,F,n4,n5,RPM_n4,'p');
    surf4 = surfacestress(m,F,n4,n5,RPM_n4,'p');

%Calc G5: output gear
    RPM_n5 = 4000*(n2/n3); %PINION RPM
    bending5 = bendingstress(m,F,n4,n5,RPM_n5,'g');
    surf5 = surfacestress(m,F,n4,n5,RPM_n5,'g');