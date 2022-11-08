function [sim_res, settings] = run_simulation(swmm, settings)

    [sim_res] = simulation.simulator(swmm, settings);

end