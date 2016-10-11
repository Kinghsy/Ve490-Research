classdef truthTable_class
    properties
        f_vec; % leftmost is indexed as 1
        input_var_number;
        var_id_vec; % if the truth table is x2,x3,x4 from left to right, then var_id_vec is [2,3,4]
        %         x1_vec = [0;0;0;0;0;0;0;0;1;1;1;1;1;1;1;1];
        %         x2_vec = [0;0;0;0;1;1;1;1;0;0;0;0;1;1;1;1];
        %         x3_vec = [0;0;1;1;0;0;1;1;0;0;1;1;0;0;1;1];
        %         x4_vec = [0;1;0;1;0;1;0;1;0;1;0;1;0;1;0;1];
        x_matrix; % 1st row is the x1 vector
    end
    methods 
        function obj = init_truthTable(obj, var_id_vec, f_vec)
            obj.f_vec = f_vec;
            obj.var_id_vec = var_id_vec;
            truthTable_var_number = length(var_id_vec);
            obj.input_var_number = truthTable_var_number;
            truthTable_row_number = 2^truthTable_var_number;
            x_matrix = [];
            for i=1:1:truthTable_row_number
                values = dec2bin(i-1)-'0';
                bin_vec = [zeros(1,truthTable_var_number-length(values)),values];
                x_matrix = [x_matrix;bin_vec];
            end
            obj.x_matrix = x_matrix;
        end
        
        function kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_var_id_vec)
            truthTable_var_id_vec = truthTable_obj.var_id_vec;
            truthTable_obj = init_truthTable(truthTable_obj, truthTable_obj.var_id_vec, truthTable_obj.f_vec);
            if(is_two_vec_equal(kmap_var_id_vec,truthTable_var_id_vec) == 1)
                kmap_new_vec = truthTable_obj.f_vec;
            else
                kmap_cell_obj_vec = [];
                for i=1:1:2^length(kmap_var_id_vec)
                    kmap_cell_obj = kmap_cell_class;
                    values = dec2bin(i-1)-'0';
                    bin_vec1 = [zeros(1,length(kmap_var_id_vec)-length(values)),values];
                    kmap_cell_obj.var_value_vec = bin_vec1;
                    kmap_cell_obj.var_id_vec = kmap_var_id_vec;
                    kmap_cell_obj_vec = [kmap_cell_obj_vec, kmap_cell_obj];
                end
                
                truthTable_var_id_left2right = truthTable_obj.var_id_vec;
                kmap_cell_var_id_vec = kmap_var_id_vec;
                index_vec = [];
                for k=1:1:length(truthTable_var_id_left2right)
                    var_id_reference = truthTable_var_id_left2right(k);
                    index = find(kmap_cell_var_id_vec==var_id_reference);
                    index_vec = [index_vec, index];
                end
                kmap_new_vec = [];
                for i=1:1:2^length(kmap_var_id_vec)
                    x_vec = [];
                    for k=1:1:length(index_vec)
                        index = index_vec(k);
                        x_bit = kmap_cell_obj_vec(i).var_value_vec(index);
                        x_vec = [x_vec,x_bit];
                    end
                    %truthTable_obj.f_vec
                    %truthTable_obj.var_id_vec
                    output_bit = get_truthTable_output_bit(truthTable_obj, x_vec);
                    kmap_cell_obj_vec(i).content_value = output_bit;
                    kmap_new_vec = [kmap_new_vec,output_bit];
                end
            end
        end
        
        function obj = set_truthTable_by_kmap(obj, kmap_obj) % use kmap to convert to its equivalent truthTable
            truthTable_var_vec = obj.var_id_vec;
            column_var_number = length(kmap_obj.column_var_id_vec);
            row_var_number = length(kmap_obj.row_var_id_vec);
            
            map_row_number = 2^row_var_number;
            map_column_number = 2^column_var_number;
            kmap_cell_obj_matrix = [];
            for i=1:1:map_row_number
                cell_row_vec = [];
                for j=1:1:map_column_number
                    kmap_cell_obj = kmap_cell_class;
                    kmap_cell_obj.content_value = kmap_obj.kmap(i,j);
                    values = dec2bin(i-1)-'0';
                    bin_vec1 = [zeros(1,row_var_number-length(values)),values];
                    values = dec2bin(j-1)-'0';
                    bin_vec2 = [zeros(1,column_var_number-length(values)),values];
                    kmap_cell_obj.var_value_vec = [bin_vec1,bin_vec2];
                    kmap_cell_obj.var_id_vec = [kmap_obj.row_var_id_vec,kmap_obj.column_var_id_vec];
                    kmap_cell_obj.content_value = kmap_obj.kmap(i,j);
                    cell_row_vec = [cell_row_vec, kmap_cell_obj];
                end
                kmap_cell_obj_matrix = [kmap_cell_obj_matrix;cell_row_vec];
            end
            
            
            %kmap_cell_obj_matrix(1,2)
            
            
            kmap_cell_var_id_left2right = [kmap_obj.row_var_id_vec, kmap_obj.column_var_id_vec];
            truthTable_var_id_vec = truthTable_var_vec;
            index_vec = [];
            for k=1:1:length(kmap_cell_var_id_left2right)
                var_id_reference = kmap_cell_var_id_left2right(k);
                index = find(truthTable_var_id_vec==var_id_reference);
                index_vec = [index_vec, index];
            end
            
            truthTable_var_number = length(truthTable_var_vec);
            truthTable_row_number = 2^truthTable_var_number;
            f_vec = [];
            for i=1:1:truthTable_row_number
                values = dec2bin(i-1)-'0';
                bin_vec = [zeros(1,truthTable_var_number-length(values)),values];
                % change bin_vec into order of kmap var_id_vec
                x_vec = [];
                for k=1:1:length(index_vec)
                    index = index_vec(k);
                    x_bit = bin_vec(index);
                    x_vec = [x_vec,x_bit]; % in kmap var id order
                end
                %obj.x_matrix = [obj.x_matrix;x_vec];
                % find the item in kmap with x_vec of var values
                for jj=1:1:size(kmap_cell_obj_matrix,1)
                    for kk=1:1:size(kmap_cell_obj_matrix,2)
                        if(is_two_vec_equal(kmap_cell_obj_matrix(jj,kk).var_value_vec,x_vec) == 1)
                            f_vec = [f_vec, kmap_cell_obj_matrix(jj,kk).content_value];
                            %break;
                        end
                    end
                end
            end
            obj.f_vec = f_vec;
        end
        
        
        function [obj,kmap_obj,row_isLeaf] = set_truthTable_by_oneRow_of_kmap(obj, kmap_obj) % condition: at least one row of kmap is not all 0s or 1s, and kmap is decomposible
            % find the first row not all 0s or 1s
            obj.var_id_vec = kmap_obj.column_var_id_vec;
            kmap = kmap_obj.kmap;
            row_isLeaf = 1;
            f_vec = [];
            for i=1:1:size(kmap, 1)
                row_vec = kmap(i,:);
                if(get_is_all_0s(row_vec)~=1 && get_is_all_1s(row_vec)~=1)
                    f_vec = row_vec;
                    kmap_obj.subfunction_row_id = i;
                    kmap_obj.majority_row_vec = row_vec;
                    kmap_obj.majority_complement_row_vec = get_complement_vec(row_vec);
                    row_isLeaf = 0;
                    break;
                end
            end
            var_id_vec = kmap_obj.column_var_id_vec;
            obj = init_truthTable(obj, var_id_vec, f_vec);
        end
        
        function [obj,kmap_obj,col_isLeaf] = set_truthTable_by_oneCol_of_kmap(obj, kmap_obj) % condition: at least one row of kmap is not all 0s or 1s, and kmap is decomposible
            % find the first row not all 0s or 1s
            obj.var_id_vec = kmap_obj.row_var_id_vec;
            kmap = kmap_obj.kmap;
            col_isLeaf = 1;
            f_vec = [];
            for i=1:1:size(kmap, 2)
                col_vec = kmap(:,i);
                col_vec = col_vec';
                if(get_is_all_0s(col_vec)~=1 && get_is_all_1s(col_vec)~=1)
                    f_vec = col_vec;
                    kmap_obj.subfunction_column_id = i;
                    kmap_obj.majority_col_vec = col_vec;
                    kmap_obj.majority_complement_col_vec = get_complement_vec(col_vec);
                    col_isLeaf = 0;
                    break;
                end
            end
            var_id_vec = kmap_obj.row_var_id_vec;
            %f_vec = f_vec';
            obj = init_truthTable(obj, var_id_vec, f_vec);
        end
        
        function obj = set_truthTable_n_inputs(obj, f_vec, var_id_vec)
            obj.var_id_vec = var_id_vec;
            input_var_number = length(var_id_vec);
            x_matrix_new = zeros(2^input_var_number,input_var_number);
            for i=1:1:size(x_matrix_new,2)
                bit = 0;
                group_element_count = 2^(input_var_number-i);
                for j=1:1:size(x_matrix_new,1)
                    x_matrix_new(j,i) = bit;
                    if(mod(j,group_element_count) == 0)
                        bit = xor(bit,1);
                    end
                end
            end
            
            obj.x_matrix = x_matrix_new;
            obj.f_vec = f_vec;
            obj.input_var_number = input_var_number;
        end
        
        function output_bit = get_truthTable_output_bit(obj, x_vec) % x_vec is in the order of obj.var_id_vec
            x_matrix_inner = obj.x_matrix;
            for i=1:1:size(x_matrix_inner,1)
                if(is_two_vec_equal(x_matrix_inner(i,:),x_vec)==1)
                    output_bit = obj.f_vec(i);
                    break;
                end
            end
            %             index_bin = [num2str(x1_bit),num2str(x2_bit),num2str(x3_bit)]; % start from 000
            %             index_dec = bin2dec(index_bin); % start from 0
            %             output_bit = obj.output_vec(index_dec+1); % index should start from 1
        end
        
        function f_vec_obtained = f_vec_verification(obj)
            var_number = obj.input_var_number;
            f_vec_obtained = [];
            for dec_value=1:1:2^var_number
                vec1 = dec2bin(dec_value-1)-'0';
                bin_vec = [zeros(1,var_number-length(vec1)),vec1];
                x_vec = bin_vec;
                output_bit = get_truthTable_output_bit(obj, x_vec);
                f_vec_obtained = [f_vec_obtained, output_bit];
            end
        end       
    end
end





