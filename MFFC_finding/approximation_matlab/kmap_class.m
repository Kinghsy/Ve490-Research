classdef kmap_class
    properties
        row_var_id_vec = []; % original x id, for x1, it is 1, for x2 it is 2
        column_var_id_vec = []; % original x id, for x1, it is 1, for x2 it is 2
        kmap = [];
        appx_kmap_2x2 = []; % only for approximated kmap obj, 2x2, with g1 and g2 as col and row variables
        boolean_expression_for_appx_kmap_2x2 = [];
        subfunction_column_id = 0; % which column is used as g1()
        subfunction_row_id = 0; % which row is used as g2()
        approximation_cost = 0;
        majority_row_vec = [];
        majority_complement_row_vec = [];
        majority_col_vec = []; % set when one col is attracted to get f_vec for the next level truth table
        majority_complement_col_vec = [];
        majority_row_vec_count = 0;
        majority_col_vec_count = 0;
        is_LUT_saved = 0;
        
    end
    methods
        
        
            
        
        function kmap_obj_modified = use_truthTable_modify_kmap_majRows(kmap_obj_modified, truthTable_obj)
            kmap_obj_col_var_id_vec = kmap_obj_modified.column_var_id_vec;
            kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_obj_col_var_id_vec);
            % set each row of majority_vec this kmap_new_vec, each row
            % of maj_complement_vec the complement of kmap_new_vec
            kmap_new_complement_vec = get_complement_vec(kmap_new_vec);
            maj_vec = kmap_obj_modified.majority_row_vec;
            maj_complement_vec = get_complement_vec(maj_vec);
            for i=1:1:size(kmap_obj_modified.kmap,1)
                vec = kmap_obj_modified.kmap(i,:);
                if(is_two_vec_equal(vec,maj_vec)==1)
                    kmap_obj_modified.kmap(i,:) = kmap_new_vec;
                elseif(is_two_vec_equal(vec,maj_complement_vec)==1)
                    kmap_obj_modified.kmap(i,:) = kmap_new_complement_vec;
                end
            end
            kmap_obj_modified.majority_row_vec = kmap_new_vec;
            kmap_obj_modified.majority_complement_row_vec = kmap_new_complement_vec;
        end
            
        function kmap_obj_modified = use_truthTable_modify_kmap_majCols(kmap_obj_modified, truthTable_obj)
            kmap_obj_row_var_id_vec = kmap_obj_modified.row_var_id_vec;
            kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_obj_row_var_id_vec);
            kmap_new_vec = kmap_new_vec'; % change to column vector
            % set each row of majority_vec this kmap_new_vec, each row
            % of maj_complement_vec the complement of kmap_new_vec
            kmap_new_complement_vec = get_complement_vec(kmap_new_vec);
            maj_vec = kmap_obj_modified.majority_col_vec; % column vector
            maj_complement_vec = get_complement_vec(maj_vec); % column vector
            for i=1:1:size(kmap_obj_modified.kmap,2)
                vec = kmap_obj_modified.kmap(:,i); % column vector
                if(is_two_vec_equal(vec',maj_vec')==1)
                    kmap_obj_modified.kmap(:,i) = kmap_new_vec;
                elseif(is_two_vec_equal(vec',maj_complement_vec')==1)
                    kmap_obj_modified.kmap(:,i) = kmap_new_complement_vec;
                end
            end
            kmap_obj_modified.majority_col_vec = kmap_new_vec';
            kmap_obj_modified.majority_complement_col_vec = kmap_new_complement_vec';
        end
            
            
        
        % this function needs to be checked! not checked yet
        function kmap_obj_modified = use_truthTable_modify_kmap_oneRow_or_oneCol(kmap_obj, truthTable_obj)
            kmap_obj_modified = kmap_obj;
            truthTable_var_id_vec = truthTable_obj.var_id_vec;
            kmap_obj_row_var_id_vec = kmap_obj_modified.row_var_id_vec;
            kmap_obj_col_var_id_vec = kmap_obj_modified.column_var_id_vec;
            % test whether the truth table is kmap row var or col var
            if(isempty(setdiff(truthTable_var_id_vec,kmap_obj_row_var_id_vec))==1) % if 1, it is row var
                kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_obj_row_var_id_vec);
                % set each row of majority_vec this kmap_new_vec, each row
                % of maj_complement_vec the complement of kmap_new_vec
                kmap_new_complement_vec = get_complement_vec(kmap_new_vec);
                maj_vec = kmap_obj_modified.majority_row_vec;
                maj_complement_vec = get_complement_vec(maj_vec);
                for i=1:1:size(kmap_obj_modified.kmap,1)
                    vec = kmap_obj_modified.kmap(i,:);
                    if(is_two_vec_equal(vec,maj_vec)==1)
                        kmap_obj_modified.kmap(i,:) = kmap_new_vec;
                    elseif(is_two_vec_equal(vec,maj_complement_vec)==1)
                        kmap_obj_modified.kmap(i,:) = kmap_new_complement_vec;
                    end
                end                    
            elseif(isempty(setdiff(truthTable_var_id_vec,kmap_obj_col_var_id_vec))==1) % if 1, it is col var
                kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_obj_col_var_id_vec);
                kmap_new_vec = kmap_new_vec'; % change to column vector
                % set each row of majority_vec this kmap_new_vec, each row
                % of maj_complement_vec the complement of kmap_new_vec
                kmap_new_complement_vec = get_complement_vec(kmap_new_vec);
                maj_vec = kmap_obj_modified.majority_col_vec; % column vector
                maj_complement_vec = get_complement_vec(maj_vec); % column vector
                for i=1:1:size(kmap_obj_modified.kmap,2)
                    vec = kmap_obj_modified.kmap(:,i); % column vector
                    if(is_two_vec_equal(vec',maj_vec')==1)
                        kmap_obj_modified.kmap(:,i) = kmap_new_vec;
                    elseif(is_two_vec_equal(vec',maj_complement_vec')==1)
                        kmap_obj_modified.kmap(:,i) = kmap_new_complement_vec;
                    end
                end
            end
        end

        
        
        
        
        function kmap_obj = set_kmap_by_truthTable(kmap_obj, truthTable_obj, column_var_id_vec, row_var_id_vec)
            %truthTable_fvec = truthTable_obj.f_vec
            column_var_number = length(column_var_id_vec);
            row_var_number = length(row_var_id_vec);
            
            kmap_obj.column_var_id_vec = column_var_id_vec;
            kmap_obj.row_var_id_vec = row_var_id_vec;
            
            
            map_row_number = 2^row_var_number;
            map_column_number = 2^column_var_number;
            kmap_obj.kmap = zeros(map_row_number,map_column_number);
            kmap_cell_obj_matrix = [];
            for i=1:1:map_row_number
                cell_row_vec = [];
                for j=1:1:map_column_number
                    kmap_cell_obj = kmap_cell_class;
                    
                    values = dec2bin(i-1)-'0';
                    bin_vec1 = [zeros(1,row_var_number-length(values)),values];
                    
                    values = dec2bin(j-1)-'0';
                    bin_vec2 = [zeros(1,column_var_number-length(values)),values];
                    
                    kmap_cell_obj.var_value_vec = [bin_vec1,bin_vec2];
                    kmap_cell_obj.var_id_vec = [row_var_id_vec,column_var_id_vec];
                    
                    cell_row_vec = [cell_row_vec, kmap_cell_obj];
                end
                kmap_cell_obj_matrix = [kmap_cell_obj_matrix;cell_row_vec];
            end
            
            % x_vec should be assigned in order of
            % truthTable_obj.var_id_vec, to get value from truthTable
            % for each cell of the kmap, the vars have 0 or 1, use them in
            % the order to get the cell's bit from truth table
            
            truthTable_var_id_left2right = truthTable_obj.var_id_vec;
            kmap_cell_var_id_vec = [row_var_id_vec,column_var_id_vec];
            index_vec = [];
            for k=1:1:length(truthTable_var_id_left2right)
                var_id_reference = truthTable_var_id_left2right(k);
                index = find(kmap_cell_var_id_vec==var_id_reference);
                index_vec = [index_vec, index];
            end
            for i=1:1:map_row_number % row index
                for j = 1:1:map_column_number % column index
                    x_vec = [];
                    for k=1:1:length(index_vec)
                        index = index_vec(k);
                        x_bit = kmap_cell_obj_matrix(i,j).var_value_vec(index);
                        x_vec = [x_vec,x_bit];
                    end
                    output_bit = get_truthTable_output_bit(truthTable_obj, x_vec);
                    kmap_cell_obj_matrix(i,j).content_value = output_bit;
                    kmap_obj.kmap(i,j) = output_bit;
                end
            end
        end
    
    
        function kmap_obj = set_appx_kmap_2x2(kmap_obj) % if only have 1 var on one side, then do not change its order according to maj_vec, but just 0,1
            app_kmap = kmap_obj.kmap; % this kmap must be in "traceBack_unit_obj.app_kmap_obj_upper_level_modified"
            maj_row_vec = kmap_obj.majority_row_vec;
            maj_col_vec = kmap_obj.majority_col_vec;
            
            if(isempty(maj_row_vec) == 0 && isempty(maj_col_vec) == 0)
                % find first 0, 1 index of these vectors
                if(length(maj_row_vec)==2 && length(maj_col_vec)>2)
%                     maj_row_vec_first_0_index = 1;
%                     maj_row_vec_first_1_index = 2;
                     maj_col_vec_1_index_vec = find(maj_col_vec == 1);
                     maj_col_vec_0_index_vec = find(maj_col_vec == 0);
                     maj_col_vec_first_0_index = maj_col_vec_0_index_vec(1);
                     maj_col_vec_first_1_index = maj_col_vec_1_index_vec(1);
                     kmap_2x2(1,:) = app_kmap(maj_col_vec_first_0_index,:);
                     kmap_2x2(2,:) = app_kmap(maj_col_vec_first_1_index,:);
                
                elseif(length(maj_col_vec)==2 && length(maj_row_vec)>2)
                    %maj_col_vec_first_0_index = 1;
                    %maj_col_vec_first_1_index = 2;
                    maj_row_vec_1_index_vec = find(maj_row_vec == 1);
                    maj_row_vec_0_index_vec = find(maj_row_vec == 0);
                    maj_row_vec_first_0_index = maj_row_vec_0_index_vec(1);
                    maj_row_vec_first_1_index = maj_row_vec_1_index_vec(1);
                    kmap_2x2(:,1) = app_kmap(:,maj_row_vec_first_0_index);
                    kmap_2x2(:,2) = app_kmap(:,maj_row_vec_first_1_index);
                elseif(length(maj_col_vec)==2 && length(maj_row_vec)==2)
                    kmap_2x2 = app_kmap;
                    
                elseif(length(maj_row_vec)>2 && length(maj_col_vec)>2)
                    maj_row_vec_1_index_vec = find(maj_row_vec == 1);
                    maj_row_vec_0_index_vec = find(maj_row_vec == 0);
                    maj_col_vec_1_index_vec = find(maj_col_vec == 1);
                    maj_col_vec_0_index_vec = find(maj_col_vec == 0);

                    maj_row_vec_first_0_index = maj_row_vec_0_index_vec(1);
                    maj_row_vec_first_1_index = maj_row_vec_1_index_vec(1);
                    maj_col_vec_first_0_index = maj_col_vec_0_index_vec(1);
                    maj_col_vec_first_1_index = maj_col_vec_1_index_vec(1);
                
                    kmap_2x2 = zeros(2,2);
                    kmap_2x2(1,1) = app_kmap(maj_col_vec_first_0_index, maj_row_vec_first_0_index);
                    kmap_2x2(1,2) = app_kmap(maj_col_vec_first_0_index, maj_row_vec_first_1_index);
                    kmap_2x2(2,1) = app_kmap(maj_col_vec_first_1_index, maj_row_vec_first_0_index);
                    kmap_2x2(2,2) = app_kmap(maj_col_vec_first_1_index, maj_row_vec_first_1_index);
                end
    %               g2
    %           g1  -----------
    %               |    |    |
    %               -----------
    %               |    |    |
    %               -----------
    %            
            elseif(isempty(maj_row_vec) == 1 && isempty(maj_col_vec) == 0) % have 4 elements in maj_col_vec
                kmap_2x2 = zeros(2,1);
                maj_col_vec_1_index_vec = find(maj_col_vec == 1);
                maj_col_vec_0_index_vec = find(maj_col_vec == 0);
                maj_col_vec_first_0_index = maj_col_vec_0_index_vec(1);
                maj_col_vec_first_1_index = maj_col_vec_1_index_vec(1);
                    
                kmap_2x2(1,1) = maj_col_vec(maj_col_vec_first_0_index);
                kmap_2x2(2,1) = maj_col_vec(maj_col_vec_first_1_index);
            
            elseif(isempty(maj_row_vec) == 0 && isempty(maj_col_vec) == 1) % have 4 elements in maj_row_vec
                kmap_2x2 = zeros(1,2);
                maj_row_vec_1_index_vec = find(maj_row_vec == 1);
                maj_row_vec_0_index_vec = find(maj_row_vec == 0);
                maj_row_vec_first_0_index = maj_row_vec_0_index_vec(1);
                maj_row_vec_first_1_index = maj_row_vec_1_index_vec(1);
                
                kmap_2x2(1,1) = maj_row_vec(maj_row_vec_first_0_index);
                kmap_2x2(1,2) = maj_row_vec(maj_row_vec_first_1_index);
            end
                
            kmap_obj.appx_kmap_2x2 = kmap_2x2;
        end
            
            
        %function [kmap_obj, fid, input_id_1, input_id_2] = set_boolean_expression_for_appx_kmap_2x2(kmap_obj, fid, output_bit_id)
        function [kmap_obj, fid, input_wire_name_left, input_wire_name_right] = set_boolean_expression_for_appx_kmap_2x2(kmap_obj, fid, output_wire_name, circuit_input_wire_names_ordered)        
            kmap = kmap_obj.appx_kmap_2x2;
            row_var_id_vec = kmap_obj.row_var_id_vec;
            col_var_id_vec = kmap_obj.column_var_id_vec;
            
            %input_id_1 = output_bit_id + 1;
            %input_id_2 = output_bit_id + 2;
                            
            % g1(col_var_id_vec), g2(row_var_id_vec)
            str = ['h = '];
            %fprintf(fid,'%s%d %s%d %s%d\n','a',1,'a',2,'a',3);
            %output_wire_name = 'w0';
            
            if(length(col_var_id_vec) == 1)
                index = col_var_id_vec(1);
                input_wire_name_left = circuit_input_wire_names_ordered(index).name;
                %input_wire_name_left = ['x',num2str(col_var_id_vec(1))];
            else
                input_wire_name_left = [output_wire_name,'_1'];
            end
            
            if(length(row_var_id_vec) == 1)
                %input_wire_name_right = ['x',num2str(row_var_id_vec(1))];
                index = row_var_id_vec(1);
                input_wire_name_right = circuit_input_wire_names_ordered(index).name;
            else
                input_wire_name_right = [output_wire_name,'_2'];
            end
            
            
            
            fprintf(fid,'%s %s %s\n',input_wire_name_left,input_wire_name_right,output_wire_name);
            if(size(kmap,1)==2 && size(kmap,2)==2)
                for i=1:1:2
                    for j=1:1:2
                        factor = kmap(i,j);
                        switch (i-1)*2+j
                            case 1
                                cofactor_str = 'g1_prime * g2_prime + ';
                                %fprintf(fid,'%d%d %d\n',);
                                bit_vec = [0 0 1];
                            case 2
                                cofactor_str = 'g1_prime * g2 + ';  
                                %fprintf(fid,'%d%d %d\n',[0 1 1]);
                                bit_vec = [1 0 1]; % g2,g1,f
                            case 3
                                cofactor_str = 'g1 * g2_prime + '; 
                                %fprintf(fid,'%d%d %d\n',[1 0 1]);
                                bit_vec = [0 1 1]; % g2,g1,f
                            case 4
                                cofactor_str = 'g1 * g2';
                                %fprintf(fid,'%d%d %d\n',[1 1 1]);
                                bit_vec = [1 1 1];
                        end
                        if(factor == 1)
                            str = [str, cofactor_str];
                            fprintf(fid,'%d%d %d\n',bit_vec); % order: g2(go left),g1(go right),output
                        end
                    end
                end
            elseif(size(kmap,1)==1 && size(kmap,2)==2)
                str = [str, 'LUT saved, only have g2'];
                kmap_obj.is_LUT_saved = 1;
                bit_vec = [1 0 1];
                fprintf(fid,'%d%d %d\n',bit_vec);
                bit_vec = [1 1 1];
                fprintf(fid,'%d%d %d\n',bit_vec);
            elseif(size(kmap,1)==2 && size(kmap,2)==1)
                str = [str, 'LUT saved, only have g1'];
                kmap_obj.is_LUT_saved = 1;
                bit_vec = [0 1 1];
                fprintf(fid,'%d%d %d\n',bit_vec);
                bit_vec = [1 1 1];
                fprintf(fid,'%d%d %d\n',bit_vec);
            end
            
            if(isempty(row_var_id_vec) == 0 && isempty(col_var_id_vec) == 0)
             
                str = [str, '; g1 = g1(x'];
                for i=1:1:length(row_var_id_vec)
                    row_var_id = row_var_id_vec(i);
                    str = [str, num2str(row_var_id), ','];
                end
                str = [str, ')'];
                str = [str, '; g2 = g2(x'];
                for i=1:1:length(col_var_id_vec)
                    col_var_id = col_var_id_vec(i);
                    str = [str, num2str(col_var_id), ','];
                end
                str = [str, ')'];
            elseif(isempty(row_var_id_vec) == 1 && isempty(col_var_id_vec) == 0)
                str = [str, '; g1 = g1(x'];
                var_id = col_var_id_vec(1);
                str = [str, num2str(var_id), ');'];
                str = [str, '; g2 = g2(x'];
                var_id = col_var_id_vec(2);
                str = [str, num2str(var_id), ');'];
            elseif(isempty(row_var_id_vec) == 0 && isempty(col_var_id_vec) == 1)
                str = [str, '; g1 = g1(x'];
                var_id = row_var_id_vec(1);
                str = [str, num2str(var_id), ');'];
                str = [str, '; g2 = g2(x'];
                var_id = row_var_id_vec(2);
                str = [str, num2str(var_id), ');'];
            end

            
            kmap_obj.boolean_expression_for_appx_kmap_2x2 = str;
        end
        
        %----------------------------------------------------
        
%         function [kmap_obj, fid] = set_boolean_expression_for_appx_kmap_2x2_leaf(kmap_obj, fid, output_wire_name, left_var_name, right_var_name)        
%             kmap = kmap_obj.appx_kmap_2x2;
%             row_var_id_vec = kmap_obj.row_var_id_vec;
%             col_var_id_vec = kmap_obj.column_var_id_vec;
%             
%             %input_id_1 = output_bit_id + 1;
%             %input_id_2 = output_bit_id + 2;
%                             
%             % g1(col_var_id_vec), g2(row_var_id_vec)
%             str = ['h = '];
%             %fprintf(fid,'%s%d %s%d %s%d\n','a',1,'a',2,'a',3);
%             %output_wire_name = 'w0';
%             input_wire_name_left = [output_wire_name,'1'];
%             input_wire_name_right = [output_wire_name,'2'];
%             fprintf(fid,'%s %s %s\n',left_var_name,right_var_name,output_wire_name);
%             if(size(kmap,1)==2 && size(kmap,2)==2)
%                 for i=1:1:2
%                     for j=1:1:2
%                         factor = kmap(i,j);
%                         switch (i-1)*2+j
%                             case 1
%                                 cofactor_str = 'g1_prime * g2_prime + ';
%                                 %fprintf(fid,'%d%d %d\n',);
%                                 bit_vec = [0 0 1];
%                             case 2
%                                 cofactor_str = 'g1_prime * g2 + ';  
%                                 %fprintf(fid,'%d%d %d\n',[0 1 1]);
%                                 bit_vec = [0 1 1];
%                             case 3
%                                 cofactor_str = 'g1 * g2_prime + '; 
%                                 %fprintf(fid,'%d%d %d\n',[1 0 1]);
%                                 bit_vec = [1 0 1];
%                             case 4
%                                 cofactor_str = 'g1 * g2';
%                                 %fprintf(fid,'%d%d %d\n',[1 1 1]);
%                                 bit_vec = [1 1 1];
%                         end
%                         if(factor == 1)
%                             str = [str, cofactor_str];
%                             fprintf(fid,'%d%d %d\n',bit_vec);
%                         end
%                     end
%                 end
%             elseif(size(kmap,1)==1 && size(kmap,2)==2)
%                 str = [str, 'LUT saved, only have g2'];
%                 kmap_obj.is_LUT_saved = 1;
%             elseif(size(kmap,1)==2 && size(kmap,2)==1)
%                 str = [str, 'LUT saved, only have g1'];
%                 kmap_obj.is_LUT_saved = 1;
%             end
%             
%             if(isempty(row_var_id_vec) == 0 && isempty(col_var_id_vec) == 0)
%              
%                 str = [str, '; g1 = g1(x'];
%                 for i=1:1:length(row_var_id_vec)
%                     row_var_id = row_var_id_vec(i);
%                     str = [str, num2str(row_var_id), ','];
%                 end
%                 str = [str, ')'];
%                 str = [str, '; g2 = g2(x'];
%                 for i=1:1:length(col_var_id_vec)
%                     col_var_id = col_var_id_vec(i);
%                     str = [str, num2str(col_var_id), ','];
%                 end
%                 str = [str, ')'];
%             elseif(isempty(row_var_id_vec) == 1 && isempty(col_var_id_vec) == 0)
%                 str = [str, '; g1 = g1(x'];
%                 var_id = col_var_id_vec(1);
%                 str = [str, num2str(var_id), ');'];
%                 str = [str, '; g2 = g2(x'];
%                 var_id = col_var_id_vec(2);
%                 str = [str, num2str(var_id), ');'];
%             elseif(isempty(row_var_id_vec) == 0 && isempty(col_var_id_vec) == 1)
%                 str = [str, '; g1 = g1(x'];
%                 var_id = row_var_id_vec(1);
%                 str = [str, num2str(var_id), ');'];
%                 str = [str, '; g2 = g2(x'];
%                 var_id = row_var_id_vec(2);
%                 str = [str, num2str(var_id), ');'];
%             end
% 
%             
%             kmap_obj.boolean_expression_for_appx_kmap_2x2 = str;
%         end
%         
        
        %----------------------------------------------------
        function [kmap_obj] = set_boolean_expression_for_appx_kmap_2x2_2(kmap_obj)
            kmap = kmap_obj.appx_kmap_2x2;
            row_var_id_vec = kmap_obj.row_var_id_vec;
            col_var_id_vec = kmap_obj.column_var_id_vec;
                            
            % g1(col_var_id_vec), g2(row_var_id_vec)
            str = ['h = '];
            
            if(size(kmap,1)==2 && size(kmap,2)==2)
                for i=1:1:2
                    for j=1:1:2
                        factor = kmap(i,j);
                        switch (i-1)*2+j
                            case 1
                                cofactor_str = 'g1_prime * g2_prime + ';
                               %fprintf(fid,'%d%d %d\n',[0 0 1]);
                            case 2
                                cofactor_str = 'g1_prime * g2 + ';  
                                %fprintf(fid,'%d%d %d\n',[0 1 1]);
                            case 3
                                cofactor_str = 'g1 * g2_prime + '; 
                                %fprintf(fid,'%d%d %d\n',[1 0 1]);
                            case 4
                                cofactor_str = 'g1 * g2';
                                %fprintf(fid,'%d%d %d\n',[1 1 1]);
                        end
                        if(factor == 1)
                            str = [str, cofactor_str];
                        end
                    end
                end
            elseif(size(kmap,1)==1 && size(kmap,2)==2)
                str = [str, 'LUT saved, only have g2'];
                kmap_obj.is_LUT_saved = 1;
            elseif(size(kmap,1)==2 && size(kmap,2)==1)
                str = [str, 'LUT saved, only have g1'];
                kmap_obj.is_LUT_saved = 1;
            end
            
            if(isempty(row_var_id_vec) == 0 && isempty(col_var_id_vec) == 0)
             
                str = [str, '; g1 = g1(x'];
                for i=1:1:length(row_var_id_vec)
                    row_var_id = row_var_id_vec(i);
                    str = [str, num2str(row_var_id), ','];
                end
                str = [str, ')'];
                str = [str, '; g2 = g2(x'];
                for i=1:1:length(col_var_id_vec)
                    col_var_id = col_var_id_vec(i);
                    str = [str, num2str(col_var_id), ','];
                end
                str = [str, ')'];
            elseif(isempty(row_var_id_vec) == 1 && isempty(col_var_id_vec) == 0)
                str = [str, '; g1 = g1(x'];
                var_id = col_var_id_vec(1);
                str = [str, num2str(var_id), ');'];
                str = [str, '; g2 = g2(x'];
                var_id = col_var_id_vec(2);
                str = [str, num2str(var_id), ');'];
            elseif(isempty(row_var_id_vec) == 0 && isempty(col_var_id_vec) == 1)
                str = [str, '; g1 = g1(x'];
                var_id = row_var_id_vec(1);
                str = [str, num2str(var_id), ');'];
                str = [str, '; g2 = g2(x'];
                var_id = row_var_id_vec(2);
                str = [str, num2str(var_id), ');'];
            end

            
            kmap_obj.boolean_expression_for_appx_kmap_2x2 = str;
        end
        %----------------------------------------------
        
        
        
        
        
        
        
        
        
        
        
        
        
            
    end
    
end


