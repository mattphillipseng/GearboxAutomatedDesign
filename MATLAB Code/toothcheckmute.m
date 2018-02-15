function options = toothcheckmute(R, min_teeth, max_teeth)

options = 0;

for tooth1=min_teeth:max_teeth
        tooth2=R*tooth1;
        if(floor(tooth2) > max_teeth)
            break;
        end 
        if(floor(tooth2) == tooth2)
           options = options+1;
        end         
end 