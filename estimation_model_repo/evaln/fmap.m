function [ievaln] = fmap(idnn, ilayer, icim, ievaln)

    switch ievaln.name
        case 'IerOerB'
            ievaln.nrow_unroll = idnn.M(ilayer);
            ievaln.ncol_unroll = idnn.N(ilayer);
            ievaln.npe_unroll = (idnn.K(ilayer))^2;

            ievaln.npe_in_g = ceil( idnn.N(ilayer) / icim.ncol );
            ievaln.npe_in_gn = idnn.K(ilayer) * ceil( idnn.M(ilayer) / icim.nrow );
            ievaln.npe_in_au = idnn.K(ilayer);

            ievaln.npe_out_g = idnn.K(ilayer)^2 * ceil( idnn.M(ilayer) / icim.nrow );
            ievaln.npe_out_gn = ceil( idnn.N(ilayer) / icim.ncol );

            ievaln.util_col = idnn.N(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = idnn.M(ilayer) / icim.nrow;
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IraOerA'
            ievaln.nrow_unroll = (idnn.K(ilayer))^2;
            ievaln.ncol_unroll = idnn.N(ilayer);
            ievaln.npe_unroll = idnn.M(ilayer);

            ievaln.npe_in_g = ceil( idnn.N(ilayer) / icim.ncol );
            ievaln.npe_in_gn = idnn.M(ilayer) * ceil( idnn.K(ilayer) / floor( icim.nrow / idnn.K(ilayer) ) );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( idnn.K(ilayer) / floor( icim.nrow / idnn.K(ilayer) ) ) * idnn.M(ilayer);
            ievaln.npe_out_gn = ceil( idnn.N(ilayer) / icim.nrow );

            ievaln.util_col = idnn.N(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = idnn.K(ilayer) / floor( icim.nrow / idnn.K(ilayer) );
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IraOerC'
            ievaln.nrow_unroll = idnn.K(ilayer) * idnn.M(ilayer);
            ievaln.ncol_unroll = idnn.N(ilayer);
            ievaln.npe_unroll = idnn.K(ilayer);

            ievaln.npe_in_g = ceil( idnn.N(ilayer) / icim.ncol );
            ievaln.npe_in_gn = idnn.K(ilayer) * ceil( idnn.M(ilayer) / floor( icim.nrow / idnn.K(ilayer) ) );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( idnn.M(ilayer) / floor( icim.nrow / idnn.K(ilayer) ) ) * idnn.K(ilayer);
            ievaln.npe_out_gn = ceil( idnn.N(ilayer) / icim.nrow );

            ievaln.util_col = idnn.N(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = idnn.M(ilayer) / floor( icim.nrow / idnn.K(ilayer) );
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IraOerD'
            ievaln.nrow_unroll = idnn.K(ilayer);
            ievaln.ncol_unroll = idnn.N(ilayer);
            ievaln.npe_unroll = idnn.K(ilayer) * idnn.M(ilayer);

            ievaln.npe_in_g = ceil( idnn.N(ilayer) / icim.ncol );
            ievaln.npe_in_gn = idnn.K(ilayer) * idnn.M(ilayer) * ceil( 1 / floor( icim.nrow / idnn.K(ilayer) ) );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( 1 / floor( icim.nrow / idnn.K(ilayer) ) ) * idnn.M(ilayer) * idnn.K(ilayer);
            ievaln.npe_out_gn = ceil( idnn.N(ilayer) / icim.nrow );

            ievaln.util_col = idnn.N(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = 1 / floor( icim.nrow / idnn.K(ilayer) );
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IerOraB'
            ievaln.nrow_unroll = idnn.M(ilayer);
            ievaln.ncol_unroll = (idnn.K(ilayer))^2;
            ievaln.npe_unroll = idnn.N(ilayer);

            ievaln.npe_in_g = idnn.N(ilayer) * ceil( (idnn.K(ilayer))^2 / icim.ncol );
            ievaln.npe_in_gn = ceil( idnn.M(ilayer) / icim.nrow );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( idnn.K(ilayer)^2 / icim.ncol ) * ceil( idnn.M(ilayer) / icim.nrow );
            ievaln.npe_out_gn = idnn.N(ilayer);

            ievaln.util_col = (idnn.K(ilayer))^2 / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = idnn.M(ilayer) / icim.nrow;
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IraOraA'
            ievaln.nrow_unroll = (idnn.K(ilayer))^2;
            ievaln.ncol_unroll = idnn.M(ilayer);
            ievaln.npe_unroll = idnn.N(ilayer);

            ievaln.npe_in_g = idnn.N(ilayer) * ceil( idnn.M(ilayer) / icim.ncol );
            ievaln.npe_in_gn = ceil( (idnn.K(ilayer))^2 / icim.nrow );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( idnn.M(ilayer) / icim.ncol ) * ceil( idnn.K(ilayer)^2 / icim.nrow );
            ievaln.npe_out_gn = idnn.N(ilayer);

            ievaln.util_col = idnn.M(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = (idnn.K(ilayer))^2 / icim.nrow;
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IraOraC'
            ievaln.nrow_unroll = idnn.M(ilayer) * idnn.K(ilayer);
            ievaln.ncol_unroll = idnn.K(ilayer);
            ievaln.npe_unroll = idnn.N(ilayer);

            ievaln.npe_in_g = idnn.N(ilayer) * ceil( idnn.K(ilayer) / icim.ncol );
            ievaln.npe_in_gn = ceil( idnn.K(ilayer) * idnn.M(ilayer) / icim.nrow );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( idnn.K(ilayer) / icim.ncol ) * ceil( idnn.K(ilayer) * idnn.M(ilayer) / icim.nrow );
            ievaln.npe_out_gn = idnn.N(ilayer);

            ievaln.util_col = idnn.K(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = idnn.K(ilayer) * idnn.M(ilayer) / icim.nrow;
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        case 'IraOraD'
            ievaln.nrow_unroll = idnn.K(ilayer);
            ievaln.ncol_unroll = idnn.M(ilayer) * idnn.K(ilayer);
            ievaln.npe_unroll = idnn.N(ilayer);

            ievaln.npe_in_g = idnn.N(ilayer) * ceil( idnn.K(ilayer) * idnn.M(ilayer) / icim.ncol );
            ievaln.npe_in_gn = ceil( idnn.K(ilayer) / icim.nrow );
            ievaln.npe_in_au = 1;

            ievaln.npe_out_g = ceil( idnn.K(ilayer) * idnn.M(ilayer) / icim.ncol ) * ceil( idnn.K(ilayer) / icim.nrow );
            ievaln.npe_out_gn = idnn.N(ilayer);

            ievaln.util_col = idnn.K(ilayer) * idnn.M(ilayer) / icim.ncol;
            if (ievaln.util_col >= 1)
                ievaln.util_col = 1;
            end

            ievaln.util_row = idnn.K(ilayer) / icim.nrow;
            if (ievaln.util_row >= 1)
                ievaln.util_row = 1;
            end

        otherwise
            ievaln.nrow_unroll = 0;
            ievaln.ncol_unroll = 0;
            ievaln.npe_unroll = 0;

            ievaln.npe_in_g = 0;
            ievaln.npe_in_gn = 0;
            ievaln.npe_in_au = 0;

            ievaln.npe_out_g = 0;
            ievaln.npe_out_gn = 0;

            ievaln.util_col = 0;
            ievaln.util_row = 0;
    end

    ievaln.npe = ievaln.npe_in_g * ievaln.npe_in_gn * ievaln.npe_in_au;
    ievaln.util = idnn.M(ilayer) * idnn.N(ilayer) * (idnn.K(ilayer))^2 / ( ievaln.npe * icim.nrow * icim.ncol ) * 100;
    

    ievaln.nsli = ((idnn.L(ilayer) + 2*idnn.P(ilayer) - idnn.K(ilayer) + 1)/idnn.S(ilayer))^2;
end