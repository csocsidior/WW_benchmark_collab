function [TT_sim, settings] = simulator(swmm,settings)

    persistent OD
    
    if isempty(OD)
        OD = zeros(6,1);
    end

    % Simulation samples
    T_stop = settings.sim.sim_time-settings.sim.dt;
    N = T_stop/settings.sim.dt;
    
    % Time keeping
    time = datetime('2022-05-28T00:00:00Z', 'InputFormat', 'uuuu-MM-dd''T''HH:mm:ssZ', 'TimeZone', 'UTC');
    time = time + seconds(0:settings.sim.dt:T_stop);

    % Timetable for measurements
    TT_sim = timetable( ...
    time', ...
    zeros(N+1, 1), ...  % t : time in seconds
    zeros(N+1, 1), ...  % h1: tank 1 level
    zeros(N+1, 1), ...  % h2: tank 2 level
    zeros(N+1, 1), ...  % h3: tank 3 level
    zeros(N+1, 1), ...  % h4: tank 4 level
    zeros(N+1, 1), ...  % h5: tank 5 level
    zeros(N+1, 1), ...  % h6: tank 6 level
    zeros(N+1, 1), ...  % q1 : valve 1 flow
    zeros(N+1, 1), ...  % q2 : valve 2 flow
    zeros(N+1, 1), ...  % q3 : valve 3 flow
    zeros(N+1, 1), ...  % q4 : valve 4 flow
    zeros(N+1, 1),...   % q5 : valve 5 flow
    zeros(N+1, 1), ...  % q6 : valve 6 flow
    zeros(N+1, 1), ...  % h_cso7 : CSO structure 1 flow
    zeros(N+1, 1), ...  % h_cso8 : CSO structure 2 flow
    zeros(N+1, 1),...   % h_cso9 : CSO structure 3 flow
    zeros(N+1, 1), ...  % h_cso10 : CSO structure 4 flow
    zeros(N+1, 1),...   % d1 : catchment 1 precipitation
    zeros(N+1, 1), ...  % d2 : catchment 2 precipitation
    zeros(N+1, 1),...   % d3 : catchment 3 precipitation
    zeros(N+1, 1), ...  % d4 : catchment 4 precipitation
    zeros(N+1, 1),...   % d5 : catchment 5 precipitation
    zeros(N+1, 1), ...  % d6 : catchment 6 precipitation
    zeros(N+1, 1),...   % d7 : catchment 7 precipitation
    zeros(N+1, 1), ...  % d8 : catchment 8 precipitation
    zeros(N+1, 1),...   % d9 : catchment 9 precipitation
    zeros(N+1, 1), ...  % d10 : catchment 10 precipitation
    zeros(N+1, 1),...   % h1_cso : tank 1 flooding
    zeros(N+1, 1),...   % h2_cso : tank 2 flooding
    zeros(N+1, 1),...   % h3_cso : tank 3 flooding
    zeros(N+1, 1),...   % h4_cso : tank 4 flooding
    zeros(N+1, 1),...   % h5_cso : tank 5 flooding
    zeros(N+1, 1),...   % h6_cso : tank 6 flooding
    zeros(N+1, 1),...   % OD1 : tank 1 opening degree
    zeros(N+1, 1),...   % OD2 : tank 2 opening degree
    zeros(N+1, 1),...   % OD3 : tank 3 opening degree
    zeros(N+1, 1),...   % OD4 : tank 4 opening degree
    zeros(N+1, 1),...   % OD5 : tank 5 opening degree
    zeros(N+1, 1),...   % OD6 : tank 6 opening degree
    zeros(N+1, 1)); ... % error - model
    
    TT_sim.Properties.VariableNames = {'t'  'h1', 'h2'  'h3', 'h4', 'h5', 'h6', 'q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'h_cso7', 'h_cso8', 'h_cso9', 'h_cso10',...
        'd1', 'd2', 'd3', 'd4', 'd5', 'd6', 'd7', 'd8', 'd9', 'd10', 'q1_cso', 'q2_cso', 'q3_cso', 'q4_cso', 'q5_cso', 'q6_cso', 'OD1', 'OD2', 'OD3', 'OD4', 'OD5', 'OD6' 'error_model'};

    try 
        for k = 1:N

            % Display execution in terminal
            if 0== mod(k,ceil(T_stop/settings.sim.dt/100))
              fprintf('%i %s \n',int32((k/N)*100),'%');
            end

            % Progress time
            TT_sim.t(k+1) = k * settings.sim.dt;
            
            % Run simulation step
            time_swmm = swmm.run_step;    

            % Read sensors - storage
            TT_sim.h1(k) = swmm.get('T1',swmm.DEPTH,swmm.SI);
            TT_sim.h2(k) = swmm.get('T2',swmm.DEPTH,swmm.SI);
            TT_sim.h3(k) = swmm.get('T3',swmm.DEPTH,swmm.SI);
            TT_sim.h4(k) = swmm.get('T4',swmm.DEPTH,swmm.SI);
            TT_sim.h5(k) = swmm.get('T5',swmm.DEPTH,swmm.SI);
            TT_sim.h6(k) = swmm.get('T6',swmm.DEPTH,swmm.SI);
            
            % Read (virtual) sensors - storage flooding
            TT_sim.q1_cso(k) = swmm.get('T1',swmm.FLOODING,swmm.SI);
            TT_sim.q2_cso(k) = swmm.get('T2',swmm.FLOODING,swmm.SI);
            TT_sim.q3_cso(k) = swmm.get('T3',swmm.FLOODING,swmm.SI);
            TT_sim.q4_cso(k) = swmm.get('T4',swmm.FLOODING,swmm.SI);
            TT_sim.q5_cso(k) = swmm.get('T5',swmm.FLOODING,swmm.SI);
            TT_sim.q6_cso(k) = swmm.get('T6',swmm.FLOODING,swmm.SI);

            % Read sensors - orifice
            TT_sim.q1(k) = swmm.get('V1',swmm.FLOW,swmm.SI); 
            TT_sim.q2(k) = swmm.get('V2',swmm.FLOW,swmm.SI); 
            TT_sim.q3(k) = swmm.get('V3',swmm.FLOW,swmm.SI); 
            TT_sim.q4(k) = swmm.get('V4',swmm.FLOW,swmm.SI); 
            TT_sim.q5(k) = swmm.get('V5',swmm.FLOW,swmm.SI); 
            TT_sim.q6(k) = swmm.get('V6',swmm.FLOW,swmm.SI); 

            % Read (virtual) sensors - flooding
            TT_sim.h_cso7(k) = swmm.get('CSO7',swmm.FLOODING,swmm.SI);
            TT_sim.h_cso8(k) = swmm.get('CSO8',swmm.FLOODING,swmm.SI);
            TT_sim.h_cso9(k) = swmm.get('CSO9',swmm.FLOODING,swmm.SI);
            TT_sim.h_cso10(k) = swmm.get('CSO10',swmm.FLOODING,swmm.SI);

            % Read (virtual) sensors - precipitation
            TT_sim.d1(k) = swmm.get('SC01',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d2(k) = swmm.get('SC02',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d3(k) = swmm.get('SC03',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d4(k) = swmm.get('SC04',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d5(k) = swmm.get('SC05',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d6(k) = swmm.get('SC06',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d7(k) = swmm.get('SC07',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d8(k) = swmm.get('SC08',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d9(k) = swmm.get('SC09',swmm.PRECIPITATION,swmm.SI);
            TT_sim.d10(k) = swmm.get('SC010',swmm.PRECIPITATION,swmm.SI);

            % Control algorithm
             if mod(TT_sim.t(k), settings.control.dt) == 0 && settings.control.variant == "ON/OFF"
    
                [OD] = algorithm.control_ruleBased(k, TT_sim, settings.control, OD);
    
             elseif mod(TT_sim.t(k), settings.control.dt) == 0 && settings.control.variant == "replDynamics"
                %********************************************

                % Here goes the developed algorithm
                %[OD] = algorithm.control_replDynamics(.);
    
                %********************************************
             end

             % Apply input 
             swmm.modify_setting('V1', OD(1));
             swmm.modify_setting('V2', OD(2));
             swmm.modify_setting('V3', OD(3));
             swmm.modify_setting('V4', OD(4));
             swmm.modify_setting('V5', OD(5));
             swmm.modify_setting('V6', OD(6));

             % Save input
             TT_sim.OD1(k) = OD(1);
             TT_sim.OD2(k) = OD(2);
             TT_sim.OD3(k) = OD(3);
             TT_sim.OD4(k) = OD(4);
             TT_sim.OD5(k) = OD(5);
             TT_sim.OD6(k) = OD(6);
                
        end
    catch 
        fprintf('Simulation error \n');
        [errors, duration] = swmm.finish;
    end 
    %f = swmm.total_flooding;
    [errors, duration] = swmm.finish;
end

