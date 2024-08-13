function [ievaln] = fevaln_trace(idnn, ilayer, icim, ievaln)
    for i=1:8
        ievaln{i} = fevaln(idnn, ilayer, icim, ievaln{i});
    end
end