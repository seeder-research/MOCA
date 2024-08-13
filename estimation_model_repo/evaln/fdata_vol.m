function [ievaln] = fdata_vol(idnn, ilayer, icim, ievaln)
% PE-averaged

    L_K = (idnn.L(ilayer) - idnn.K(ilayer))/idnn.S(ilayer);
    L_K_1 = (idnn.L(ilayer) + 2*idnn.P(ilayer) - idnn.K(ilayer) + 1)/idnn.S(ilayer);
    
    switch ievaln.name
        case 'IerOerB'
            ievaln.difirs = icim.nrow * ievaln.npe / ievaln.npe_in_g;
            ievaln.disubs = icim.nrow * ievaln.npe / ievaln.npe_in_g / idnn.K(ilayer);
            ievaln.dipe = (ievaln.difirs + L_K * ievaln.disubs) / L_K_1 / ievaln.npe;
            ievaln.ditt = ievaln.dipe * ievaln.npe;
            
            ievaln.dope = icim.ncol;
            %%%%%%%%%%%% To be confirmed %%%%%%%%%%%%%%
            ievaln.dott = ievaln.dope * ievaln.npe * L_K_1^2;
            %%%%%%%%%%%% To be confirmed %%%%%%%%%%%%%%
            ievaln.ddott = idnn.N(ilayer) * L_K_1^2;
            
            %%%%%%%%%%%% To be confirmed %%%%%%%%%%%%%%
            ievaln.dpinter = 0;
            %%%%%%%%%%%% To be confirmed %%%%%%%%%%%%%%
            
        case {'IraOerA', 'IraOerC', 'IraOerD'}
            n_sf_en = min(ceil(ievaln.nrow_unroll / idnn.K(ilayer)), floor(icim.nrow / idnn.K(ilayer))); 
            
            ievaln.difirs = icim.nrow * ievaln.npe / ievaln.npe_in_g;
            ievaln.disubs = n_sf_en * ievaln.npe / ievaln.npe_in_g;
            ievaln.dipe = (ievaln.difirs + L_K * ievaln.disubs) / L_K_1 / ievaln.npe;
            ievaln.ditt = ievaln.dipe * ievaln.npe;
            
            ievaln.dope = icim.ncol;
            ievaln.dott = ievaln.dope * ievaln.npe * L_K_1^2;
            ievaln.ddott = idnn.N(ilayer) * L_K_1^2;

            ievaln.dpintra = (icim.nrow - n_sf_en) * ievaln.npe;
            ievaln.dpintra = ievaln.dpintra * L_K / L_K_1 / ievaln.npe;

        case {'IerOraB', 'IraOraA', 'IraOraC', 'IraOraD'}
            ievaln.dipe = icim.nrow * icim.ncol / ievaln.npe_in_g;
            ievaln.ditt = ievaln.dipe * ievaln.npe;
            
            ievaln.dope = 1;
            ievaln.dott = ievaln.dope * ievaln.npe * L_K_1^2;
            ievaln.ddott = idnn.N(ilayer) * L_K_1^2;

        otherwise
            ievaln.dipe = 0;
            ievaln.ditt = 0;
            
            ievaln.dope = 0;
            ievaln.dott = 0;
    end

end