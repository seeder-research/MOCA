function [ievaln] = fenergy(idnn, ilayer, icim, ievaln)

    switch ievaln.name
        case {'IerOerB', 'IraOerA', 'IraOerC', 'IraOerD'}
            ievaln.eape = icim.ncol * ievaln.npe * (icim.eam + icim.ear) *ievaln.util_col *ievaln.util_row;  % "*ievaln.util_col" is a new feature during calibration
            if ievaln.name=='IerOerB'
                ievaln.ebpe = (icim.ebr + icim.ebw) * ievaln.ditt;
            else
                ievaln.ebpe = (icim.ebr + icim.ebw) * ievaln.ditt + icim.eintra * ievaln.dpintra;
            end

        case {'IerOraB', 'IraOraA', 'IraOraC', 'IraOraD'}
            ievaln.eape = icim.ncol * ievaln.npe * (icim.ncol * icim.eam + icim.ear);
            ievaln.ebpe = (icim.ebr + icim.ebw) * ievaln.ditt;

        otherwise
            ievaln.eape = 0;
            ievaln.ebpe = 0;
    end
    
    ievaln.emm = icim.emr * ievaln.ditt;
    ievaln.edc = icim.edacc * ievaln.dott + icim.emw * ievaln.ddott;
    ievaln.es = (icim.pml + icim.pbl) * ievaln.ttot;
    ievaln.eco = (ievaln.eape + ievaln.ebpe + ievaln.emm) * ievaln.nsli + ievaln.edc + ievaln.es;

    ievaln.ecobd = zeros(1,5);
    ievaln.ecobd(1,1) = ievaln.eape * ievaln.nsli;
    ievaln.ecobd(1,2) = ievaln.ebpe * ievaln.nsli;
    ievaln.ecobd(1,3) = ievaln.emm * ievaln.nsli;
    ievaln.ecobd(1,4) = ievaln.edc;
    ievaln.ecobd(1,5) = ievaln.es;
    
end