function stress = surfacestress(m, F, N_p, N_g, RPM, targetGear)
%RPM OF PINIONS IS INPUT
% stress = Cp * root((Wt* Ca * Cm * Cs * Cf)/(F * i * d * Cv))

P=40; %HP

if(targetGear == 'g')
%%%%Operating parameters%%%%
        omega = RPM * 2 * pi * (1/60)*(N_p/N_g); %angular velocity [rad/s]
        r_g = 0.5*m*N_g; %pitch radius [mm]
        Vt = r_g*(1/1000) * omega; %Pitch-line velocity [m/s]
        Qv = 11; %Gear quality index
%Application factor (Ca)
        %If uniform driving machine, uniform driven
        Ca = 1;       
%Surface finish factor (Cf)
        %No established standards
        Cf = 1;   
%Size Factor (Cs)
        %Adjust if massive teeth, otherwise:
        Cs = 1;          
%Dynamic factor (Cv)
        %From equation 12.17b    
        B = 0.25*(12 - Qv)^(2/3);
        A = 50 + 56*(1 - B);
        Cv = (A / (A + sqrt(200*Vt)))^B;   
%Load distribution factor (Cm)
        %Depends on face width & module/diametral pitch
        %   8/pd < F < 16/pd
        if(m <= 3.75)
            Cm = 1.6;
        else
            error("Adjust Cm value, module exceeds max");
        end
%Elastic Coefficient (Cp)
        %All gears of same material
        elastic_mod = 2E5; %[MPa]
        poisson = 0.3;
        Cp = sqrt((1/(pi*(2*(1 - poisson^2)/elastic_mod))));
%Surface Geometry Factor (I)
        %Radius of curvature of teeth of pinion (rho_p)
            phi = 20; %pressure angle [deg]
            p_d = 25.4/m;%diametral pitch [inch]
            r_p_in = (0.5 * (N_p/p_d)); %pitch radius of pinion [in]
            x_p = 0; %standard full depth teeth, x_p = 0;
        rho_p = sqrt((r_p_in + (1 + x_p)/(p_d))^2 - (r_p_in*cosd(phi))^2) - (pi*cosd(phi))/p_d; %[in]

        %Radius of curvature of teeth of gear(rho_g)
            pitch_rad_pin = N_p/(2*p_d); %[in]
            pitch_rad_gear = N_g/(2*p_d); %[in]
            C = pitch_rad_pin + pitch_rad_gear; %[in]
        rho_g = C * sind(phi) - rho_p; %[in] 
    
        I = cosd(phi)/(((1/rho_p) + (1/rho_g))* (2*r_p_in)); 
%Tangential Load (Wt)
    %
    P = P * 745.699872; %Power conversion to watts
    torque = P/omega;%[N*m]   
    Wt = (torque*1000)/r_g; %[N]   
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Final calculation
    d_p_g = N_g*m;
    stress = Cp * sqrt((Wt* Ca * Cm * Cs * Cf)/(F * I * d_p_g * Cv));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if(targetGear == 'p')
%%%%Operating parameters%%%%
        omega = RPM * 2 * pi * (1/60); %angular velocity [rad/s]
        r_p = 0.5*m*N_p; %pitch radius [mm]
        Vt = r_p*(1/1000) * omega; %Pitch-line velocity [m/s]
        Qv = 11; %Gear quality index
%Application factor (Ca)
        %If uniform driving machine, uniform driven
        Ca = 1;       
%Surface finish factor (Cf)
        %No established standards
        Cf = 1;    
%Size Factor (Cs)
        %Adjust if massive teeth, otherwise:
        Cs = 1;          
%Dynamic factor (Cv)
        %From equation 12.17b    
        B = 0.25*(12 - Qv)^(2/3);
        A = 50 + 56*(1 - B);
        Cv = (A / (A + sqrt(200*Vt)))^B;   
%Load distribution factor (Cm)
        %Depends on face width & module/diametral pitch
        %   8/pd < F < 16/pd
        if(m <= 3.75)
            Cm = 1.6;
        else
            error("Adjust Cm value, module exceeds max");
        end
%Elastic Coefficient (Cp)
        %All gears of same material
        elastic_mod = 2E5; %[MPa]
        poisson = 0.3;
        Cp = sqrt((1/(pi*(2*(1 - poisson^2)/elastic_mod))));  
%Surface Geometry Factor (I)
        %Radius of curvature of teeth of pinion (rho_p)
            phi = 20; %pressure angle [deg]
            p_d = 25.4/m;%diametral pitch
            r_p_in = (0.5 * (N_p/p_d)); %pitch radius of pinion [in]
            x_p = 0; %standard full depth teeth, x_p = 0;
        rho_p = sqrt((r_p_in + (1 + x_p)/(p_d))^2 - (r_p_in*cosd(phi))^2) - (pi*cosd(phi))/p_d; %[in]

        %Radius of curvature of teeth of gear(rho_g)
            pitch_rad_pin = N_p/(2*p_d); %[in]
            pitch_rad_gear = N_g/(2*p_d); %[in]
            C = pitch_rad_pin + pitch_rad_gear; %[in]
    
        rho_g = C * sind(phi) - rho_p; %[in] 
    
        I = cosd(phi)/(((1/rho_p) + (1/rho_g))* 2 * r_p_in); 
%Tangential Load (Wt)
    %
    P = P * 745.699872; %Power conversion to watts
    torque = P/omega;%[N*m]   
    Wt = (torque*1000)/r_p; %[N]   
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Final calculation
    d_p = N_p*m;
    stress = Cp * sqrt((Wt* Ca * Cm * Cs * Cf)/(F * I * d_p * Cv));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



   

