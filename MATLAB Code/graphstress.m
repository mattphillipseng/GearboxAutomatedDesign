function points = graphstress(n2, n3, n4, n5, type)

%Calculating Load Cycles and strengths for each gear
    S_fb_prime = 450; %MPa
    S_fc_prime = 1500; %Mpa

    %0.5 applied because having a reduction >8 and satefy factor above 1.1 practically impossibe
    cycles_n2 = 2.971 * 10^8;
    cycles_n3 = cycles_n2 * (n3/n2);
    cycles_n4 = cycles_n3;
    cycles_n5 = cycles_n3 * (n5/n4);
    
    K_T = (460+104)/620;
    K_R = 1.00; %reliab 99%
    
    %LIFE FACTORS, equations found in excel
        K_L_bend_g2 = (-0.034*log(cycles_n2))+1.6042; %log is natural log, log10 is log base 10
        K_L_bend_g3 = (-0.034*log(cycles_n3))+1.6042;
        K_L_bend_g4 = (-0.034*log(cycles_n4))+1.6042;
        K_L_bend_g5 = (-0.034*log(cycles_n5))+1.6042;

        C_L_surf_g2 = -0.045*log(cycles_n2)+1.7233;
        C_L_surf_g3 = -0.045*log(cycles_n3)+1.7233;
        C_L_surf_g4 = -0.045*log(cycles_n4)+1.7233;
        C_L_surf_g5 = -0.045*log(cycles_n5)+1.7233;
    
    %corrected_bending_fatigue_strength = 350;  %MPa %This will be deleted
    %corrected_surface_fatigue_strength = 1111; %MPa %This will be deleted

    % STRENGTHS
        S_fb_g2 = (K_L_bend_g2 * S_fb_prime)/(K_T * K_R);
        S_fb_g3 = (K_L_bend_g3 * S_fb_prime)/(K_T * K_R);
        S_fb_g4 = (K_L_bend_g4 * S_fb_prime)/(K_T * K_R);
        S_fb_g5 = (K_L_bend_g5 * S_fb_prime)/(K_T * K_R);

        S_fc_g2 = (C_L_surf_g2 * S_fc_prime)/(K_T * K_R);
        S_fc_g3 = (C_L_surf_g3 * S_fc_prime)/(K_T * K_R);
        S_fc_g4 = (C_L_surf_g4 * S_fc_prime)/(K_T * K_R);
        S_fc_g5 = (C_L_surf_g5 * S_fc_prime)/(K_T * K_R);
    
    %Module min
        m_min = 1.3;
        n_biggest = max(n3,n5);  
    %Module max
        m_max = min(  (230/(n_biggest+2))  ,  300/(2+n5+0.5*n4+0.5*n3)   );  
    %Step Sized
        MASTER_STEP = 500; %Change plot resolution
        m_step = 1/MASTER_STEP;
        F_step = 1/MASTER_STEP;
    i=1;    
  
    points = zeros(MASTER_STEP);
    X = zeros(MASTER_STEP);
    Y = zeros(MASTER_STEP);
       
    for mod=m_min:((m_max - m_min)*m_step):m_max 
        %Face width min    
            F_min = 8*mod;
        %Face width max
            F_max = 16*mod;
        j=1;
        
        for face=F_min:((F_max - F_min)*F_step):F_max
            X(i,j) = mod; 
            Y(i,j) = face;            
            [bending2,bending3,bending4, bending5, surf2, surf3, surf4 , surf5] = stresscalculations(n2,n3,n4,n5,mod,face);
            
            points2b(i,j) = S_fb_g2/bending2;       
            points3b(i,j) = S_fb_g3/bending3; 
            points4b(i,j) = S_fb_g4/bending4; 
            points5b(i,j) = S_fb_g5/bending5; 
            
            points2c(i,j) = (S_fc_g2/surf2)^2; 
            points3c(i,j) = (S_fc_g3/surf3)^2; 
            points4c(i,j) = (S_fc_g4/surf4)^2; 
            points5c(i,j) = (S_fc_g5/surf5)^2;       
            
            if(i==300 && j == 300)
               fprintf("At a modulus of: %f, a face width of: %f\n", mod, face);
               fprintf("Bending Stress of Crit (N4) [MPa]: %f\n", bending4);
               fprintf("Surface Stress of Crit (N4) [MPa]: %f\n", surf4);
               reductionratio = (n3/n2)*(n5/n4);
               fprintf("Reduction Ratio: %f, RPM Out: %f\n",reductionratio,4000*(1/reductionratio));
            end
            
            j = j +1;            
        end 
        
        i = i +1;
    end
  
% For contour lines
%zmin= 0.5;
%zmax= 5.0;
%zinc= 0.1;
%zlevs= zmin:zinc:zmax;
%zlevs = 1.1;
    
%%%%%%%%%%%%%%%%%% Gear 2 %%%%%%%%%%%%%%%%%%
    figure;
    subplot(1,2,1) 
        if(type == 'a')
            mesh(X, Y, points2b);
        else
            contourf(X, Y, points2b,'ShowText','on');
        end       
        %axis([0 5 0 50 1.1 3]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title("Safety Factors on G2")
    subplot(1,2,2)
        if(type == 'a')
            mesh(X, Y, points2c);
        else
            contourf(X, Y, points2c,'ShowText','on');
        end    
        %axis([0 5 0 50 1.1 3]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title("Safety Factors on G2");    
            
            
            
%%%%%%%%%%%%%%%%%% Gear 3 %%%%%%%%%%%%%%%%%%
    figure;
    subplot(1,2,1)    
        if(type == 'a')
            mesh(X, Y, points3b);
        else
            contourf(X, Y, points3b,'ShowText','on');
        end         
        %axis([0 3 0 3 0 10000]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title("Safety Factors on G3")

    subplot(1,2,2)
        if(type == 'a')
            mesh(X, Y, points3c);
        else
            contourf(X, Y, points3c,'ShowText','on');
        end   
        %axis([0 3 0 3 0 10000]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title("Safety Factors on G3");
            
            
            
%%%%%%%%%%%%%%%%%% Gear 4 %%%%%%%%%%%%%%%%%%
    figure;
    subplot(1,2,1)    
        if(type == 'a')
            mesh(X, Y, points4b);
        else
            contourf(X, Y, points4b,'ShowText','on');
        end  
        %axis([0 3 0 3 0 10000]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title(sprintf('Safety Factors on G4'));
    subplot(1,2,2)
        if(type == 'a')
            mesh(X, Y, points4c);
        else
            contourf(X, Y, points4c,'ShowText','on');
        end  
        %axis([0 3 0 3 0 10000]);
            %For graph titles
                g2=n2;
                g3=n3;
                g4=n4;
                g5=n5;
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            %title(sprintf('Surface stresses on G4.\nTeeth: %d, %d, %d, %d\nReduction: %f',g2,g3,g4,g5,reductionratio));
            title("Safety Factors on G4");
            
            
            
%%%%%%%%%%%%%%%%%% Gear 5 %%%%%%%%%%%%%%%%%%
    figure;
    subplot(1,2,1)    
        if(type == 'a')
            mesh(X, Y, points5b);
        else
            contourf(X, Y, points5b,'ShowText','on');
        end  
        %axis([0 3 0 3 0 10000]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title("Safety Factors on G5");
    subplot(1,2,2)
        if(type == 'a')
            mesh(X, Y, points5c);
        else
            contourf(X, Y, points5c,'ShowText','on');
        end  
        %axis([0 3 0 3 0 10000]);
            xlabel('Module [mm]');
            ylabel('Face width [mm]');
            zlabel('Safety factor');
            title("Safety Factors on G5");
            
end
    
    
            
            
            
            
            
            
            
   % mesh(X, Y, points2b);
   % mesh(X, Y, points2c);
        
    %mesh(X, Y, points3b);
   % mesh(X, Y, points3c);
        
   % mesh(X, Y, points4b);
   % mesh(X, Y, points4c);    
   
    %colormap(hot);
    %axis([0 3 0 3 0 663]);
      
    
