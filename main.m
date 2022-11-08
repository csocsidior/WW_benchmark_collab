clc;
clear all;

%% Simulate

[swmm,settings] = simulation.setup(SWMM, 'swmm_files\Astlingen_SWMM.INP', 'ON/OFF', 10*24*3600);

[sim_res, settings] = simulation.run_simulation(swmm,settings);

%% Plot

plotter;