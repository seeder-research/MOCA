function [ievaln] = fevaln(idnn, ilayer, icim, ievaln)
    ievaln = fmap(idnn, ilayer, icim, ievaln);
    ievaln = fdata_vol(idnn, ilayer, icim, ievaln);
    ievaln = ftime(idnn, ilayer, icim, ievaln);
    ievaln = fenergy(idnn, ilayer, icim, ievaln);
end