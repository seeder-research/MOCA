function [cim] = init_cim()
    % Data calibrated to X. Peng, R. Liu and S. Yu, "Optimizing Weight Mapping and Data Flow for Convolutional Neural Networks on Processing-in-Memory Architectures," in IEEE Transactions on Circuits and Systems I: Regular Papers, vol. 67, no. 4, pp. 1333-1343, April 2020, doi: 10.1109/TCSI.2019.2958568.
    
    cim = struct( ...
        "fmain", 1e9, ...   % The digital frequency (Hz)
        "fanlg", 0.2*1e9, ...   % The analog frequency (Hz)
        "nrow", 128, ...    % Number of rows per crossbar
        "ncol", 128 ...    % Number of columns per crossbar
        );

    cim = struct( ...
        "kmr", 8, ...       % Number of rows that multiplex one ADC % TCASI'20
        "ncfg", 3, ...     
        "nsft", 1, ...      
        "ndigi", 8, ...     % Number of digital computing units
        "tytd", 8*cim.fmain, ...       % Digital computing throughput (Operations/cycle)
        "alpha", 1.1, ...
        "beta", 1.1, ...
        "gamma", 1.1, ...
        "tla", 1/cim.fmain, ...        % Time per addition (s)
        ...
        "tac", 1/cim.fanlg, ...    % Time on analog computing (s)
        "tar", 1/cim.fanlg, ...  % Time on analog output generation (s), TVLSI'20
        "bwbpe", 1*cim.fmain, ...      % (Bytes/cycle)
        "bwbo", 10*cim.fmain, ...       % (Bytes/cycle)
        "bwbi", 10*cim.fmain, ...       % (Bytes/cycle)
        "bwmm", 64*cim.fmain, ...       % (Bytes/cycle), ASPDAC'22
        "eam", (0.37e-12 + 0.27e-12 + 0.24e-12)*128, ...       %J, TCASI'20
        "ear", (22.45e-12 + 1.6e-12), ...       %J, TCASI'20
        "ebr", 0.064e-12, ...            %J per bit, TCASI'20
        "ebw", 0.064e-12, ...            %J per bit, TCASI'20
        "emr", 0.254e-12, ...              %J per bit, TCASI'20
        "emw", 0.254e-12, ...              %J per bit, TCASI'20
        "eintra", 1.6e-12, ...  %J, assumed
        "edacc", 15.9e-12, ...   %J, TCASI'20
        "pml", (21.96+6.38)*10^(-3), ...    %W, ASPDAC'22
        ... %(21.96+6.38)*10^(-3)
        "pbl", 17e-9 * (128+128)*4, ...      %W per bit, ASPDAC'22, "128+128" stands for the size of the buffer
        ... %17e-9 * (128+128)*4
        "fmain", 1e9, ...   % The digital frequency (Hz)
        "fanlg", 0.2*1e9, ...   % The analog frequency (Hz)
        "nrow", 128, ...    % Number of rows per crossbar
        "ncol", 128 ...    % Number of columns per crossbar
        );
end