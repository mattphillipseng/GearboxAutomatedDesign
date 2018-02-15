clc;
clear all;

%Mechanical Advantage
m_a = 8;

%module
module = 3;

%addendum
ad = module;

%Maximum diameter for ANY gear; based on gearbox geometry
GEAR_MAX_DIAM = 230;

%Standard from books
%      If pinion has 16 teeth, gear can have no more than 101  teeth
%      If pinion has 17 teeth, gear can have no more than 1309 teeth
%We check this manually
min_teeth = 18;

%Maximum tooth (comes from d_max)
max_teeth = floor((GEAR_MAX_DIAM/module)-2);

%variables

%R1 = n3/n2;
%R2 = n5/n4;

%gearbox size
GBOX_MAX_HEIGHT = 300;

fprintf('************************************************************************************\n');
fprintf('************************************************************************************\n');
fprintf('Script was run with the following parameters:\n\n');
fprintf('Mechanical advantage (m_a):\t %d\n', m_a);
fprintf('Minimum teeth on a gear:\t %d\n', min_teeth);
fprintf('Maximum teeth on a gear:\t %d\n', max_teeth);
fprintf('Module (m):\t\t\t %f\n', module);
fprintf('Gearbox size [mm]:\t\t %d\n\n', GBOX_MAX_HEIGHT);
fprintf('************************************************************************************\n');
fprintf('************************************************************************************\n');


for R1=2.0:0.01:4.5    
    R2 = 8/R1;
    if(toothcheckmute(R1,min_teeth,max_teeth) ~= 0 && toothcheckmute(R2,min_teeth,max_teeth) ~=0)        
        fprintf('\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
        fprintf('For R1 = %f, R2 = %f\n', R1, R2);
        fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
        [optionsR1, n_valsR1] = toothcheck(R1,min_teeth,max_teeth, module);
        [optionsR2, n_valsR2] = toothcheck(R2,min_teeth,max_teeth, module);
        
        for j=1:optionsR1
            for k=1:optionsR2
                n2 = n_valsR1(j, 1);
                n3 = n_valsR1(j, 2);
                n4 = n_valsR2(k, 1);
                n5 = n_valsR2(k, 2);
                
                total_size = module*(2 + n5 + 0.5*n4 + 0.5*n3);
            
                    if(total_size <= GBOX_MAX_HEIGHT)
                        if(abs(n2 - n4) <=5 && abs(n3 - n5) <=5)
                            fprintf('N2 = %d, N3 = %d, N4 = %d, N5 = %d yields a size of: %f **********\n', n2, n3, n4, n5, total_size);
                            
                        else 
                            fprintf('N2 = %d, N3 = %d, N4 = %d, N5 = %d yields a size of: %f\n', n2, n3, n4, n5, total_size);                         
                        end
                    end
            end
        end    
        
    end 
        
end