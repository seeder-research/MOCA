function [] = frealnn( )
    
    path = "./output/realnn";

    cim = init_cim();
    dnn = init_dnn();
    
    % 1-LENET5 2-ALEXNET 3-VGG16 4-VGG19 5-RESNET18 6-RESNET34 7-RESNET50 8-RESNET101 9-RESNET152
    DNN_ID = 6;     % 6-RESNET34 
    num_layer = size(dnn{DNN_ID}.M, 2);     % 2-column number
    
    record_time_l = zeros(num_layer, 8);
    record_time_total = zeros(1, 8);
    record_energy_bd = zeros(num_layer, 8, 5);
    record_energy_l = zeros(8, 5);
    record_energy_l_pct = zeros(8, 5);
    record_energy_total = zeros(1, 8);
    
    for idx_ly = 1:num_layer     % i is the index of layer
        evaln = init_evaln();
        evaln = fevaln_trace(dnn{DNN_ID}, idx_ly, cim, evaln);   % The 2nd parameter is 1 as there's only one element in "dnn". 
        
        for idx_mp = 1:8         % j is the index of mapping method
            record_time_l(idx_ly, idx_mp) = evaln{idx_mp}.ttot;
            record_time_total(1, idx_mp) = record_time_total(1, idx_mp) + evaln{idx_mp}.ttot;

            record_energy_bd(idx_ly, idx_mp, :) = evaln{idx_mp}.ecobd(1, :);
            record_energy_l(idx_mp, :) = record_energy_l(idx_mp, :) + evaln{idx_mp}.ecobd(1, :);
            record_energy_total(1,idx_mp) = record_energy_total(1,idx_mp) + evaln{idx_mp}.eco;
        end
    end
    
    for idx_mp = 1:8
        record_energy_l_pct(idx_mp, :) = record_energy_l(idx_mp, :) / record_energy_total(1,idx_mp) * 100;
    end
    
    save(path+'/record_time_l_realnn.mat','record_time_l');
    save(path+'/record_time_total_realnn.mat','record_time_total');
    save(path+'/record_energy_bd_realnn.mat','record_energy_bd');
    save(path+'/record_energy_l_realnn.mat','record_energy_l');
    save(path+'/record_energy_total_realnn.mat','record_energy_total');
    save(path+'/record_energy_l_pct_realnn.mat','record_energy_l_pct');
end