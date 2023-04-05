function [OD] = control_replDynamics(k, TT, settings, OD) 

    if k==1
        %initial opening percentage of gates
        OD = [1;0.5;0.5;0.5;0.5;0.5]; 
    else
        %% parameters
        epsilon = 0.05;
        beta = 0.05;
        
        %% sub-system 1: Tanks 3 and 6 (convergent)
        %population
        P1 = 1; 
        %population playing strategy 6
        x1_6 = OD(6); 
        %population playing strategy 3 (receptor tank)
        x1_3 = P1-x1_6; 
        
        %fitness functions
        f1_6 =  -(settings.level_max(6)-TT.h6(k)) + epsilon/(x1_6-1);
        f1_3 =  -(settings.level_max(3)-TT.h3(k));
        
        %average fitness
        bar_f1 = (1/P1)*(x1_6*f1_6 + x1_3*f1_3); 
        
        %replicator equation:
        x1_6 = x1_6 + beta*x1_6*(f1_6-bar_f1);
        x1_3 = x1_3 + beta*x1_3*(f1_6-bar_f1);
        
        %opening percentage of gate 6
        OD(6) = x1_6; 
        
        
        %% sub-system 2: Tanks 1-5 (convergent)
        P2 = 4; %population
        x2_2 = OD(2); %population playing strategy 2
        x2_3 = OD(3); %population playing strategy 3
        x2_4 = OD(4); %population playing strategy 4
        x2_5 = OD(5); %population playing strategy 5
        x2_1 = P2-(x2_2+x2_3+x2_4+x2_5); %population playing strategy 1 (receptor tank)
        
        %fitness functions
        f2_2 =  -(settings.level_max(2)-TT.h2(k)) + epsilon/(x2_2-1); 
        f2_3 =  -(settings.level_max(3)-TT.h3(k)) + epsilon/(x2_3-1); 
        f2_4 =  -(settings.level_max(4)-TT.h4(k)) + epsilon/(x2_4-1); 
        f2_5 =  -(settings.level_max(5)-TT.h5(k)) + epsilon/(x2_5-1); 
        f2_1 =  -(settings.level_max(1)-TT.h1(k)); 
        
        %average fitness
        bar_f2 = (1/P2)*(x2_2*f2_2 + x2_3*f2_3 + x2_4*f2_4 + x2_5*f2_5 + x2_1*f2_1); 
        
        %replicator equation:
        x2_2 = x2_2 + beta*x2_2*(f2_2-bar_f2);
        x2_3 = x2_3 + beta*x2_3*(f2_3-bar_f2);
        x2_4 = x2_4 + beta*x2_4*(f2_4-bar_f2);
        x2_5 = x2_5 + beta*x2_5*(f2_5-bar_f2);
        x2_1 = x2_1 + beta*x2_1*(f2_1-bar_f2);
        
        OD(1) = 1;    %opening percentage of gate 1
        OD(2) = x2_2; %opening percentage of gate 2
        OD(3) = x2_3; %opening percentage of gate 3
        OD(4) = x2_4; %opening percentage of gate 4
        OD(5) = x2_5; %opening percentage of gate 5
    
    
    end

end