function j = geometryfactor(N_p, N_g, targetGear);


if(targetGear == 'g')
     %Pin   21      26      35      55      135     %gear  
table = [   0.33,   0.00,   0.00,   0.00,   0.00;   %21
            0.35,   0.35,   0.00,   0.00,   0.00;   %26
            0.37,   0.38,   0.39,   0.00,   0.00;   %35
            0.40,   0.41,   0.42,   0.43,   0.00;   %55
            0.43,   0.44,   0.45,   0.47,   0.49;];  %135
        
%Pinion column assignment        
if(21<= N_p && N_p < 26)
    firstcol = 1;
    x1 = 21;
    secondcol = 2;
    x2 = 26;
elseif(26<= N_p && N_p < 35)
    firstcol = 2;
    x1 = 26;
    secondcol = 3;
    x2 = 35;
elseif(35<= N_p && N_p < 55)
    firstcol = 3;
    x1 = 35;
    secondcol = 4;
    x2 = 55;
elseif(55<= N_p && N_p <= 135)
    firstcol = 4;
    x1 = 55;
    secondcol = 5;
    x2 = 135;
else
    j=0.33; 
    return % For when less than 21 teeth
end

%Gear row assignment 
if(21<= N_g && N_g < 26)
    firstrow = 1;
    y1 = 21;
    secondrow = 2;
    y2 = 26;
elseif(26<= N_g && N_g < 35)
    firstrow  = 2;
    y1 = 26;
    secondrow = 3;
    y2 = 35;
elseif(35<= N_g && N_g < 55)
    firstrow  = 3;
    y1 = 35;
    secondrow = 4;
    y2 = 55;
elseif(55<= N_g && N_g <= 135)
    firstrow  = 4;
    y1 = 55;
    secondrow = 5;
    y2 = 135;
else
    j=0.34; return % For when less than 21 teeth
end

x = N_p;
y = N_g;

Q11 = table(firstrow, firstcol);
Q21 = table(firstrow, secondcol);
Q12 = table(secondrow, firstcol);
Q22 = table(secondrow, secondcol);

j = ((x2-x)*(y2-y)*Q11)/((x2 - x1)*(y2-y1)) + ((x - x1)*(y2-y)*Q21)/((x2 - x1)*(y2-y1)) + ((x2 - x)*(y - y1)*Q12)/((x2 - x1)*(y2-y1)) + ((x-x1)*(y-y1)*Q22)/((x2 - x1)*(y2-y1));
end

if(targetGear == 'p')
     %Pin   21      26      35      55      135     %gear  
table = [   0.33,   0.00,   0.00,   0.00,   0.00;   %21
            0.33,   0.35,   0.00,   0.00,   0.00;   %26
            0.34,   0.36,   0.39,   0.00,   0.00;   %35
            0.34,   0.37,   0.40,   0.43,   0.00;   %55
            0.35,   0.38,   0.41,   0.45,   0.49;];  %135
        
%Pinion column assignment        
if(21<= N_p && N_p < 26)
    firstcol = 1;
    x1 = 21;
    secondcol = 2;
    x2 = 26;
elseif(26<= N_p && N_p < 35)
    firstcol = 2;
    x1 = 26;
    secondcol = 3;
    x2 = 35;
elseif(35<= N_p && N_p < 55)
    firstcol = 3;
    x1 = 35;
    secondcol = 4;
    x2 = 55;
elseif(55<= N_p && N_p <= 135)
    firstcol = 4;
    x1 = 55;
    secondcol = 5;
    x2 = 135;
else
    j=0.33; return % For when less than 21 teeth
end

%Gear row assignment 
if(21<= N_g && N_g < 26)
    firstrow = 1;
    y1 = 21;
    secondrow = 2;
    y2 = 26;
elseif(26<= N_g && N_g < 35)
    firstrow  = 2;
    y1 = 26;
    secondrow = 3;
    y2 = 35;
elseif(35<= N_g && N_g < 55)
    firstrow  = 3;
    y1 = 35;
    secondrow = 4;
    y2 = 55;
elseif(55<= N_g && N_g <= 135)
    firstrow  = 4;
    y1 = 55;
    secondrow = 5;
    y2 = 135;
else
    j=0.34; return %For when less than 21 teeth
end

x = N_p;
y = N_g;

Q11 = table(firstrow, firstcol);
Q21 = table(firstrow, secondcol);
Q12 = table(secondrow, firstcol);
Q22 = table(secondrow, secondcol);

j = ((x2-x)*(y2-y)*Q11)/((x2 - x1)*(y2-y1)) + ((x - x1)*(y2-y)*Q21)/((x2 - x1)*(y2-y1)) + ((x2 - x)*(y - y1)*Q12)/((x2 - x1)*(y2-y1)) + ((x-x1)*(y-y1)*Q22)/((x2 - x1)*(y2-y1));
end





        
            