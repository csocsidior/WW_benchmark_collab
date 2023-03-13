clc;
clear all;

addpath(genpath('dependencies'))
addpath(genpath('swmm_files'))

%% Simulate

%[swmm,settings] = simulation.setup(SWMM, 'swmm_files\Astlingen_SWMM.INP', 'ON/OFF', 3*24*3600);
[swmm,settings] = simulation.setup(SWMM, 'swmm_files\Astlingen_SWMM.INP', 'replDynamics', 7*24*3600);

[sim_res, settings] = simulation.run_simulation(swmm,settings);

%% Plot

plotter;