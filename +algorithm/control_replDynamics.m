function [OD] = control_ruleBased(k, TT, settings, OD)
    
% Replicator dynamics algorithm goes here. 

%% initial conditions
if k==1
    OD = [1;0.5;0.5;0.5;0.5;0.5]; %initial opening percentage of gates
else

%% parameters
epsilon = 0.05;
beta = 0.1;

%% sub-system 1: Tanks 3 and 6 (convergent)
P1 = 1; %population
x1_6 = OD(6); %population playing strategy 6
x1_3 = P1-x1_6; %population playing strategy 3 (receptor tank)

%fitness functions
f1_6 =  -(settings.level_max(6)-TT.h6(k)) + epsilon/(x1_6-1);
f1_3 =  -(settings.level_max(3)-TT.h3(k));

bar_f1 = (1/P1)*(x1_6*f1_6 + x1_3*f1_3); %average fitness

%replicator equation:
x1_6 = x1_6 + beta*x1_6*(f1_6-bar_f1);
x1_3 = x1_3 + beta*x1_3*(f1_6-bar_f1);

OD(6) = x1_6; %opening percentage of gate 6


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

bar_f2 = (1/P2)*(x2_2*f2_2 + x2_3*f2_3 + x2_4*f2_4 + x2_5*f2_5 + x2_1*f2_1); %average fitness

%replicator equation:
x2_2 = x2_2 + beta*x2_2*(f2_2-bar_f2);
x2_3 = x2_3 + beta*x2_3*(f2_3-bar_f2);
x2_4 = x2_4 + beta*x2_4*(f2_4-bar_f2);
x2_5 = x2_5 + beta*x2_5*(f2_5-bar_f2);
x2_1 = x2_1 + beta*x2_1*(f2_1-bar_f2);

OD(1) = 1; %opening percentage of gate 1
OD(2) = x2_2; %opening percentage of gate 2
OD(3) = x2_3; %opening percentage of gate 3
OD(4) = x2_4; %opening percentage of gate 4
OD(5) = x2_5; %opening percentage of gate 5


end

end