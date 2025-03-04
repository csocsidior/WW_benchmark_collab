function [swmm, settings] = setup(swmm, path, control_variant, simulationDuration)

    % Object IDs from the SWMM *.inp file
    settings.ID.link = swmm.get_all(path, swmm.LINK, swmm.NONE);                            
    settings.ID.node = swmm.get_all(path, swmm.NODE, swmm.NONE);                            
    settings.ID.catchment = swmm.get_all(path, swmm.SUBCATCH, swmm.NONE);
    settings.ID.storage = swmm.get_all(path, swmm.STORAGE, swmm.NONE);                      
    settings.ID.orifice = swmm.get_all(path, swmm.ORIFICE, swmm.NONE);
    
    % Initialize simulation network
    swmm.initialize(path)

    % Simulation duration
    settings.sim.simulationDuration = simulationDuration;
    % Simulation time step
    settings.sim.timeStep = 30;  %[seconds]
    % Control time step
    settings.control.timeStep = 120; %[seconds]
    % Control variant
    settings.control.variant = control_variant;
    
    % Tank physical constraints
    settings.control.level_max(1) = 2.5;
    settings.control.level_max(2) = 5;
    settings.control.level_max(3) = 2.5;
    settings.control.level_max(4) = 2.5;
    settings.control.level_max(5) = 5;
    settings.control.level_max(6) = 5;
    settings.control.level_min(1) = 0.3;
    settings.control.level_min(2) = 0.3;
    settings.control.level_min(3) = 0.3;
    settings.control.level_min(4) = 0.3;
    settings.control.level_min(5) = 0.3;
    settings.control.level_min(6) = 0.3;
    
    % Valve opening degree constraints
    settings.control.OD_max(1) = 1;
    settings.control.OD_max(2) = 1;
    settings.control.OD_max(3) = 1;
    settings.control.OD_max(4) = 1;
    settings.control.OD_max(5) = 1;
    settings.control.OD_max(6) = 1;
    settings.control.OD_min(1) = 0;
    settings.control.OD_min(2) = 0;
    settings.control.OD_min(3) = 0;
    settings.control.OD_min(4) = 0;
    settings.control.OD_min(5) = 0;
    settings.control.OD_min(6) = 0;

end