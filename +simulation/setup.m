function [swmm, settings] = setup(swmm, path, control_variant, sim_time)

    % Object IDs from the SWMM *.inp file
    settings.ID.link = swmm.get_all(path, swmm.LINK, swmm.NONE);                            
    settings.ID.node = swmm.get_all(path, swmm.NODE, swmm.NONE);                            
    settings.ID.catchment = swmm.get_all(path, swmm.SUBCATCH, swmm.NONE);
    settings.ID.storage = swmm.get_all(path, swmm.STORAGE, swmm.NONE);                      
    settings.ID.orifice = swmm.get_all(path, swmm.ORIFICE, swmm.NONE);
    
    % Initialize simulator network
    swmm.initialize(path)

    settings.sim.sim_time = sim_time;
    settings.control.variant = control_variant;
    settings.control.dt = 120;
    settings.sim.dt = 30;  %[seconds]

    % Tank physical constraints
    settings.control.level_max(1) = 4.5;
    settings.control.level_max(2) = 4.5;
    settings.control.level_max(3) = 4.5;
    settings.control.level_max(4) = 4.5;
    settings.control.level_max(5) = 4.5;
    settings.control.level_max(6) = 4.5;
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