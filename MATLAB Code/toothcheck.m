function [options, n_vals]  = toothcheck(R, min_teeth, max_teeth, m)

options = 0;

for tooth1=min_teeth:max_teeth
        tooth2=R*tooth1;
        if(floor(tooth2) > max_teeth)
            break;
        end 
        if(floor(tooth2) == tooth2)
          % fprintf("n2 = %d, n3 = %d\n", tooth1, tooth2); 
           n_vals(options+1,1) = tooth1;
           n_vals(options+1, 2) = tooth2;           
           options = options+1;
           
        end         
end 