function stress = bendingstress(m, F, N_p, N_g, RPM, targetGear)
%RPM OF PINIONS IS INPUT
% stress = (Wt * Ka * Km * Ks * Kb * Ki)/(F*m*J*Kv)

P=40; %HP

if(targetGear=='g')
%%%%Operating parameters%%%%
    omega = RPM * 2 * pi * (1/60)*(N_p/N_g); %angular velocity [rad/s]
    r_g = 0.5*m*N_g; %pitch radius [mm]
    Vt = r_g*(1/1000) * omega; %Pitch-line velocity [m/s]
    Qv = 11; %Gear quality index
%Application factor (Ka)
    %If uniform driving machine, uniform driven
        Ka = 1;
%Idler Factor (Ki)
    %Our system has no idlers
        Ki = 1;
%Size Factor (Ks)
    %Adjust if massive teeth, otherwise:
        Ks = 1;   
%Rim thickness factor (Kb)
    %Applies if gear design has spokes
        Kb = 1;
%Dynamic factor (Kv)
    %From equation 12.17b
        B = 0.25*(12 - Qv)^(2/3);
        A = 50 + 56*(1 - B);
        Kv = (A / (A + sqrt(200*Vt)))^B;
%Load distribution factor (Km)
    %Depends on face width & module/diametral pitch
        %8/pd < F < 16/pd
        if(m <= 3.75)
            Km = 1.6;
        else
            error("Adjust km value, module exceeds max");
        end
%Bending Geometry Factor (J) 
    J = geometryfactor(N_p, N_g, 'g');
%Tangential Load (Wt)
    P = P * 745.699872; %Power conversion to watts
    torque = P/omega;%[N*m]
    Wt = (torque*1000)/r_g; %[N]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Final calculation
    stress = (Wt * Ka * Km * Ks * Kb * Ki)/(F*m*J*Kv);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
    

if(targetGear=='p')
%%%%Operating parameters%%%%
    omega = RPM * 2 * pi * (1/60); %angular velocity [rad/s]
    r_p = 0.5*m*N_p; %pitch radius [mm]
    Vt = r_p*(1/1000) * omega; %Pitch-line velocity [m/s]
    Qv = 11; %Gear quality index
%Application factor (Ka)
    %If uniform driving machine, uniform driven
        Ka = 1;
%Idler Factor (Ki)
    %Our system has no idlers
        Ki = 1;
%Size Factor (Ks)
    %Adjust if massive teeth, otherwise:
        Ks = 1;   
%Rim thickness factor (Kb)
    %Applies if gear design has spokes
        Kb = 1;
%Dynamic factor (Kv)
    %From equation 12.17b
        B = 0.25*(12 - Qv)^(2/3);
        A = 50 + 56*(1 - B);
        Kv = (A / (A + sqrt(200*Vt)))^B;
%Load distribution factor (Km)
    %Depends on face width & module/diametral pitch
        %8/pd < F < 16/pd
        if(m <= 3.75)
            Km = 1.6;
        else
            error("Adjust km value, module exceeds max");
        end
%Bending Geometry Factor (J) 
    J = geometryfactor(N_p, N_g, 'p');
%Tangential Load (Wt)
    P = P * 745.699872; %Power conversion to watts
    torque = P/omega;%[N*m]
    Wt = (torque*1000)/r_p; %[N]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Final calculation
    stress = (Wt * Ka * Km * Ks * Kb * Ki)/(F*m*J*Kv);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
    
   
        
    
    
    
