function [] = froof_line_nn()
    
    cim = init_cim();
    dnn = init_dnn();
    
    % 1-LENET5 2-ALEXNET 3-VGG16 4-VGG19 5-RESNET18 6-RESNET34 7-RESNET50 8-RESNET101 9-RESNET152
    DNN_ID_start = 1;
    DNN_ID_end = 9;
    
    for DNN_ID = DNN_ID_start:DNN_ID_end
        
        num_layer = size(dnn{DNN_ID}.M, 2);     % 2-column number
        
        path = "./output/rooflinenn/nn"+string(DNN_ID);
        
        if not(isfolder(path))
            mkdir(path);
        end
        
        var1_bound = 15;
        var2_bound = 15;
        
        is_print_energy = 1;
        is_print_time = 1;
        is_print_type_min_energy = 1;
        is_print_type_min_time = 1;
        
        fenergy = fopen(path+"/output_energy_breakdown.txt", "W");
        ftime = fopen(path+"/output_time_breakdown.txt", "W");
        ftype_min_energy = fopen(path+"/output_type_min_energy.txt", "W");
        ftype_min_time = fopen(path+"/output_type_min_time.txt", "W");
        
        record_energy = zeros(var1_bound,var2_bound,8);     % 3-D
        record_time = zeros(var1_bound,var2_bound,8);
        record_area = zeros(var1_bound,var2_bound,8);
        
        record_type_min_time = zeros(var1_bound,var2_bound);    % 2-D
        record_min_time = zeros(var1_bound,var2_bound);    % 2-D
        
        for m=1:var1_bound
            for n=1:var2_bound
    
                cim.bwmm = 10*m;
                cim.tytd = 10*n;
                
                for idx_ly = 1:num_layer
                    
                    evaln = init_evaln();   % clear old data and restart in every cycle
                    evaln = fevaln_trace(dnn{DNN_ID}, idx_ly, cim, evaln);   % The 2nd parameter is 1 as there's only one element in "dnn". 
                    
                    for i = 1:8    % trace all eight mapping methods
                        
                        record_energy(m,n,i) = record_energy(m,n,i) + evaln{i}.eco;
                        record_time(m,n,i) = record_time(m,n,i) + evaln{i}.ttot;
                        record_area(m,n,i) = record_area(m,n,i) + evaln{i}.npe;
                        
                        % print energy breakdown
                        if is_print_energy == 1
                            fprintf(fenergy, '(m, n, i) = (%3d, %3d, %3d); [%30f|%30f|%30f|%30f|%30f]\n', m, n, i, evaln{i}.ecobd(1,1), evaln{i}.ecobd(1,2), evaln{i}.ecobd(1,3), evaln{i}.ecobd(1,4), evaln{i}.ecobd(1,5));
                        end
        
                        % print time breakdown
                        if is_print_time == 1
                            fprintf(ftime, '(m, n, i) = (%3d, %3d, %3d); [%30f|%30f|%30f|%30f|%30f|%30f]\n', m, n, i, evaln{i}.ttotbd(1,1), evaln{i}.ttotbd(1,2), evaln{i}.ttotbd(1,3), evaln{i}.ttotbd(1,4), evaln{i}.ttotbd(1,5), evaln{i}.ttotbd(1,6));
                        end
                    end
                end
    
    
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if is_print_type_min_energy==1
                    temp_min_energy = min( record_energy(m,n,:) );
                    fprintf(ftype_min_energy, "(m, n) = (%3d, %3d);  ", m, n);
                
                    for i=1:8
                        if record_energy(m,n,i)==temp_min_energy
                            fprintf(ftype_min_energy, "%3d ", i);
                        end
                    end
                    fprintf(ftype_min_energy, "\n");
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if is_print_type_min_time==1
                    temp_min_time = min( record_time(m,n,:) );
                    fprintf(ftype_min_time, "(m, n) = (%3d, %3d);  ", m, n);
                
                    for i=1:8
                        if record_time(m,n,i)==temp_min_time
                            fprintf(ftype_min_time, "%3d ", i);
                        end
                    end
                    fprintf(ftype_min_time, "\n");
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
                temp_min_time = min( record_time(m,n,:) );
                [a,b]=find(record_time(m,n,:)==temp_min_time);
                record_type_min_time(m,n)=b(1);
    
                record_min_time(m,n) = temp_min_time;
            end
        end
        
        %% Plot the contour for each mapping method
    
        for i=1:var1_bound
            X(i)=10*i;
        end
        
        for i=1:var2_bound
            Y(i)=10*i;
        end
        
        for i=1:8
            figure;
            % surfc(X, Y, log10( record_time(:,:,i) ));
            contour3(X, Y, log10( record_time(:,:,i) ), 'linewidth',2);
            % contour3(X, Y, normalize( record_time(:,:,i) ), 'linewidth',2);
            % contour3(X, Y, record_time(:,:,i), 'linewidth',2);
            ax = gca;
            ax.FontSize = 14; 
            xlabel('BW_{mm}', 'Rotation',30);
            ylabel('TYT_{dc}','Rotation',-25);
            zlabel('lg(T_{tot}) (s)');
            % set(ax,'xscale','log');
            % set(ax,'yscale','log');
            % set(ax,'zscale','log');
            % zlim([-4, 6]);
            % ax.XAxis.TickValues = [1.0e0, 1.0e5, 1.0e10, 1.0e15];
            % ax.YAxis.TickValues = [1.0e0, 1.0e5, 1.0e10, 1.0e15];
            % ax.ZAxis.TickValues = [1.0e0, 1.0e2, 1.0e4, 1.0e6];
    
            exportgraphics(gcf,path+"/fig-roofline-"+string(i)+"-nn"+string(DNN_ID)+".jpg",'ContentType','image', 'Resolution', 300);
            close;
        end
    
        %% Plot the roofline model
    
        figure;
        for j=1:var2_bound
            log_x(j)=10*j;
        end
    
        start  = 1;
        step = 2;
        stop = 7;
        point_list = [1, 2, 3, 5, 7];
        len_point_list = size(point_list);
        for j=1:len_point_list(2)
            i = point_list(j);
            semilogy(log_x, 1./record_min_time(i,:), ":*", 'linewidth', 3, 'DisplayName', ''+string(i)+'0');
            hold on;
        end
        grid on;
        ax = gca;
        ax.FontSize = 15; 
        % ax.XAxis.TickValues = [1.0e-5, 1.0e-3, 0, 1.0e3, 1.0e5];
        xlabel('TYT_{dc} (add/s)');
        ylabel('lg(1/T_{nn}) (1/s)');
        leg = legend('Location', 'southeast');
        title(leg,'BW_{mm}');
        exportgraphics(gcf,path+"/fig-roofline-roofline-nn"+string(DNN_ID)+".jpg",'ContentType','image', 'Resolution', 600);
        close;
        
    %% Plot the 3d surf
    
        figure;
        [X,Y] = meshgrid(1:var1_bound,1:var2_bound);
        surfc(X, Y, log10( record_min_time ));
        exportgraphics(gcf,path+"/fig-roofline-surf-nn"+string(DNN_ID)+".jpg",'ContentType','image', 'Resolution', 300);
        close; 
        
        %% Export the data files
    
        fclose(fenergy);
        fclose(ftime);
        fclose(ftype_min_energy);
        fclose(ftype_min_time);
    
        save(path+'/record_type_min_time_nn.mat','record_type_min_time');
        save(path+'/record_min_time_nn.mat','record_min_time');

    end
end