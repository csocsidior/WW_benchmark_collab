function [OD] = control_ruleBased(k, TT, settings, OD)
    
    % Gate 1
    i = 1;
    if TT.h1(k) >= settings.level_max(i)
        OD(i) = settings.OD_max(i);
    elseif TT.h1(k) <= settings.level_min(i)
        OD(i) = settings.OD_min(i);
    end

    % Gate 2
    i = 2;
    if TT.h2(k) >= settings.level_max(i)
        OD(i) = settings.OD_max(i);
    elseif TT.h2(k) <= settings.level_min(i)
        OD(i) = settings.OD_min(i);
    end

    % Gate 3
    i = 3;
    if TT.h3(k) >= settings.level_max(i)
        OD(i) = settings.OD_max(i);
    elseif TT.h3(k) <= settings.level_min(i)
        OD(i) = settings.OD_min(i);
    end

    % Gate 4
    i = 4;
    if TT.h4(k) >= settings.level_max(i)
        OD(i) = settings.OD_max(i);
    elseif TT.h4(k) <= settings.level_min(i)
        OD(i) = settings.OD_min(i);
    end

    % Gate 5
    i = 5;
    if TT.h5(k) >= settings.level_max(i)
        OD(i) = settings.OD_max(i);
    elseif TT.h5(k) <= settings.level_min(i)
        OD(i) = settings.OD_min(i);
    end

    % Gate 6
    i = 6;
    if TT.h6(k) >= settings.level_max(i)
        OD(i) = settings.OD_max(i);
    elseif TT.h6(k) <= settings.level_min(i)
        OD(i) = settings.OD_min(i);
    end

end