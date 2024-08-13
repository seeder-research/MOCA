function [ievaln] = ftime(idnn, ilayer, icim, ievaln)

    ievaln.tbo = ievaln.dope/icim.bwbo;
    ievaln.tmr = icim.alpha * ievaln.npe * ievaln.dipe / icim.bwmm;

    ievaln.tdc = icim.beta * ievaln.dope * ievaln.npe/(icim.tytd * icim.ndigi);
    ievaln.tmw = icim.alpha * ievaln.ddott / icim.bwmm;

    switch ievaln.name
        case {'IerOerB', 'IraOerA', 'IraOerC', 'IraOerD'}
            ievaln.tape = icim.tac + icim.kmr * icim.tar;
            if (ievaln.name == 'IerOerB')
                ievaln.tbi = ievaln.dipe/icim.bwbi + icim.ncfg/icim.fmain;
            else
                ievaln.tbi = ievaln.dipe/icim.bwbi + icim.nsft/icim.fmain;
            end
            ievaln.tpe = ievaln.tbi + ievaln.tape + ievaln.tbo;
            ievaln.ttot = ievaln.tmr + ievaln.tpe + ievaln.tdc + ievaln.tmw + icim.gamma*(icim.ncol-1)*max([ievaln.tmr, ievaln.tpe, ievaln.tdc, ievaln.tmw]);

        case {'IerOraB', 'IraOraA', 'IraOraC', 'IraOraD'}
            ievaln.tape = icim.tac + icim.tar;
            ievaln.tbi = ievaln.dipe/icim.bwbi;
            ievaln.tpe = ievaln.tbi + ievaln.tape + icim.tla;
            ievaln.tmpos = ievaln.tmr + ievaln.tpe + (icim.ncol-1)*max(ievaln.tmr, ievaln.tpe);
            ievaln.ttot = ievaln.tmpos + ievaln.tdc + ievaln.tmw + icim.gamma*(icim.ncol-1)*max([ievaln.tmpos, ievaln.tdc, ievaln.tdc]);
    end
    
    % latency breakdown
    ievaln.ttotbd = zeros(1,5);
    ievaln.ttotbd(1) = ievaln.ttot;
    ievaln.ttotbd(2) = ievaln.tdc;
    ievaln.ttotbd(3) = ievaln.tmr + ievaln.tmw;
    ievaln.ttotbd(4) = ievaln.tape;
    ievaln.ttotbd(5) = ievaln.tbi + ievaln.tbo;
    if ievaln.tpe>ievaln.tmr
        ievaln.ttotbd(6) = 1;
    else
        ievaln.ttotbd(6) = 0;
    end
end