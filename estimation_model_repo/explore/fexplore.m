function [] = fexplore()
    
    cim = init_cim();
    
    for kernel_size = 1:2:11
        
        var1_bound = 512;
        var2_bound = 512;
        
        NUM_ENERGY_BREAKDOWN = 5;
        
        path = "./output/explore/kernel"+string(kernel_size);
        
        if not(isfolder(path))
            mkdir(path);
        end
        
        is_print_energy = 1;
        is_print_time = 1;
        is_print_type_min_energy = 1;
        is_print_type_min_time = 1;
        is_print_type_max_util = 1;
        
        fenergy = fopen(path+"/output_energy_breakdown.txt", "W");
        ftime = fopen(path+"/output_time_breakdown.txt", "W");
        ftype_min_energy = fopen(path+"/output_type_min_energy.txt", "W");
        ftype_min_time = fopen(path+"/output_type_min_time.txt", "W");
        ftype_max_util = fopen(path+"/output_type_max_util.txt", "W");
        ftype_united = fopen(path+"/output_type_united.txt", "W");
        
        record_energy = zeros(var1_bound,var2_bound,8);     % 3-D
        record_time = zeros(var1_bound,var2_bound,8);     % 3-D
        record_area = zeros(var1_bound,var2_bound,8);     % 3-D
        record_util = zeros(var1_bound,var2_bound,8);     % 3-D
        record_heatmap = zeros(var1_bound,var2_bound,3,8);     % 4-D
        record_energy_breakdown = zeros(var1_bound,var2_bound,8,NUM_ENERGY_BREAKDOWN);     % 4-D
    
        for m=1:var1_bound
            for n=1:var2_bound
    
                % a make-up conv layer
                dnn.M=m;
                dnn.N=n;
                dnn.L=28;
                dnn.K=kernel_size;
                dnn.P=1;
                dnn.S=1;
                
                evaln = init_evaln();   % clear old data and restart in every cycle
                evaln = fevaln_trace(dnn, 1, cim, evaln);   % The 2nd parameter is 1 as there's only one element in "dnn". 
                
                for i = 1:8    % trace all eight mapping methods
                    
                    record_energy(m,n,i) = evaln{i}.eco;
                    record_time(m,n,i) = evaln{i}.ttot;
                    record_area(m,n,i) = evaln{i}.npe;
                    record_util(m,n,i) = evaln{i}.util;
                    for j=1:NUM_ENERGY_BREAKDOWN
                        record_energy_breakdown(m,n,i,j)=evaln{i}.ecobd(1,j);
                    end
                    
                    % print energy breakdown
                    if is_print_energy == 1
                        fprintf(fenergy, '(m, n, i) = (%3d, %3d, %3d); [%30f|%30f|%30f|%30f|%30f]\n', m, n, i, evaln{i}.ecobd(1,1), evaln{i}.ecobd(1,2), evaln{i}.ecobd(1,3), evaln{i}.ecobd(1,4), evaln{i}.ecobd(1,5));
                    end
    
                    % print time breakdown
                    if is_print_time == 1
                        fprintf(ftime, '(m, n, i) = (%3d, %3d, %3d); [%30f|%30f|%30f|%30f|%30f|%30f]\n', m, n, i, evaln{i}.ttotbd(1,1), evaln{i}.ttotbd(1,2), evaln{i}.ttotbd(1,3), evaln{i}.ttotbd(1,4), evaln{i}.ttotbd(1,5), evaln{i}.ttotbd(1,6));
                    end
                end
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fprintf(ftype_united, "(m, n) = (%3d, %3d)   |  ", m, n);
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if is_print_type_min_energy==1
                    temp_min_energy = min( record_energy(m,n,:) );
                    fprintf(ftype_min_energy, "(m, n) = (%3d, %3d);  ", m, n);
                    fprintf(ftype_united, "min.energy: %10f   |", temp_min_energy);
                    
                    for i=1:8
                        if record_energy(m,n,i)==temp_min_energy
                            fprintf(ftype_min_energy, "%3d ", i);
                            fprintf(ftype_united, "%3d ", i);
                            record_heatmap(m,n,1,i)=1;
                        end
                    end
                    fprintf(ftype_min_energy, "\n");
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
                fprintf(ftype_united, "|   ");
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if is_print_type_min_time==1
                    temp_min_time = min( record_time(m,n,:) );
                    fprintf(ftype_min_time, "(m, n) = (%3d, %3d);  ", m, n);
                    fprintf(ftype_united, "min.time: %10f   |", temp_min_time);
                
                    for i=1:8
                        if record_time(m,n,i)==temp_min_time
                            fprintf(ftype_min_time, "%3d ", i);
                            fprintf(ftype_united, "%3d ", i);
                            record_heatmap(m,n,2,i)=1;
                        end
                    end
                    fprintf(ftype_min_time, "\n");
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
                fprintf(ftype_united, "|   ");
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if is_print_type_max_util==1
                    temp_max_util = max( record_util(m,n,:) );
                    fprintf(ftype_max_util, "(m, n) = (%3d, %3d); max.util = %10f| ", m, n, temp_max_util);
                    fprintf(ftype_united, "max.util: %10f   |", temp_max_util);
                
                    for i=1:8
                        if record_util(m,n,i)==temp_max_util
                            fprintf(ftype_max_util, "%3d ", i);
                            fprintf(ftype_united, "%3d ", i);
                            record_heatmap(m,n,3,i)=1;
                        end
                    end
                    fprintf(ftype_max_util, "\n");
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
                fprintf(ftype_united, "|\n");
                
                % figure;
                % record_heatmap_2d = reshape(record_heatmap(m,n,:,:), 3, 8)';
                % imagesc(record_heatmap_2d);
    
            end
        end
        
        [X,Y] = meshgrid(1:var1_bound,1:var2_bound);
    
        save(path+'/record_heatmap.mat','record_heatmap');
        save(path+'/record_energy.mat','record_energy');
        save(path+'/record_time.mat','record_time');
        save(path+'/record_util.mat','record_util');
        save(path+'/record_energy_breakdown.mat','record_energy_breakdown');
    
        fclose(fenergy);
        fclose(ftime);
        fclose(ftype_min_energy);
        fclose(ftype_min_time);
        fclose(ftype_max_util);
        fclose(ftype_united);

    end
end
