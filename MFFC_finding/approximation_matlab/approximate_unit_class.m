classdef approximate_unit_class
    properties
        is_leaf = 0; % if #var of truthTable_obj_input <= 2, then it is leaf
        row_var_id_vec_input;
        col_var_id_vec_input;
        truthTable_obj_input;
        kmap_obj;
        kmap_approximated_obj;
        approximate_error_bit_count = 0;
        truthTable_left_obj_output;
        truthTable_right_obj_output;
    end
    methods
        function obj = set_approximate_kmap_maj_rowCol_count(obj)
            app_kmap = obj.kmap_approximated_obj.kmap;
            maj_row_vec = obj.kmap_approximated_obj.majority_row_vec; % row vector
            maj_col_vec = obj.kmap_approximated_obj.majority_col_vec; % column vector
            maj_row_vec_count = 0;
            maj_col_vec_count = 0;
            for i=1:1:size(app_kmap,1) % row
                if(is_two_vec_equal(maj_row_vec,app_kmap(i,:)) == 1)
                    maj_row_vec_count = maj_row_vec_count + 1;
                end
            end
            for i=1:1:size(app_kmap,2) % col
                if(is_two_vec_equal(maj_col_vec',app_kmap(:,i)') == 1)
                    maj_col_vec_count = maj_col_vec_count + 1;
                end
            end
            obj.kmap_approximated_obj.majority_row_vec_count = maj_row_vec_count;
            obj.kmap_approximated_obj.majority_col_vec_count = maj_col_vec_count;
        end
            
            
        function obj = set_approximate_error_bit_count(obj)
            obj.approximate_error_bit_count = sum(sum(obj.kmap_approximated_obj.kmap ~= obj.kmap_obj.kmap));
        end
        function app_unit_obj = set_isLeaf(app_unit_obj, truthTable_obj_input)
            num_var = truthTable_obj_input.input_var_number;
            if(num_var <= 2)
                app_unit_obj.is_leaf = 1;
            else
                app_unit_obj.is_leaf = 0;
            end
        end
        function app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input, enable_fast_mode, dont_care_upper_bound)
            app_unit_obj = set_isLeaf(app_unit_obj, truthTable_obj_input);
            if(app_unit_obj.is_leaf == 0)
                app_unit_obj = set_approximate_unit_helper(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input, enable_fast_mode, dont_care_upper_bound);
            %end
            %app_unit_obj
                app_unit_obj = set_approximate_error_bit_count(app_unit_obj);
                app_unit_obj = set_approximate_kmap_maj_rowCol_count(app_unit_obj);
            end
        end    
        function app_unit_obj = set_approximate_unit_helper(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input, enable_fast_mode, dont_care_upper_bound)
            % convert this truth table to the kmap
            kmap_obj = kmap_class;
            app_unit_obj.truthTable_obj_input = truthTable_obj_input;
            app_unit_obj.row_var_id_vec_input = row_var_id_vec_input;
            app_unit_obj.col_var_id_vec_input = col_var_id_vec_input;
            row_var_id_vec = row_var_id_vec_input;
            column_var_id_vec = col_var_id_vec_input;
            %truthTable_obj_input_varIdVec = truthTable_obj_input.var_id_vec;
            %truthTable_obj_input_fvec = truthTable_obj_input.f_vec
            
            kmap_obj = set_kmap_by_truthTable(kmap_obj, truthTable_obj_input, column_var_id_vec, row_var_id_vec);
            app_unit_obj.kmap_obj = kmap_obj;

            % get the approximated kmap
            %kmap_obj.kmap
            [kmap_approximate_obj,approximate_error_count] = approximation_core(kmap_obj, enable_fast_mode, dont_care_upper_bound);
            app_unit_obj.kmap_approximated_obj = kmap_approximate_obj;
            
            % set truthTable_left(row vec based) and truthTable_right(col vec based)
            % first, set truthTable_left
            
            % "app_unit_obj.kmap_approximated_obj.kmap" shall be all 0s or
            % all 1s, if so, return immediately     
            approximate_kmap = app_unit_obj.kmap_approximated_obj.kmap;
            if(get_table_is_all_0s(approximate_kmap)==1 || get_table_is_all_1s(approximate_kmap)==1)
                app_unit_obj.is_leaf = 1;
                return;
            else
                % first, if the rows are not all-0s or all-1s set truthTable_left
                truthTable_left_obj = truthTable_class;            
                [truthTable_left_obj,app_unit_obj.kmap_approximated_obj,row_isLeaf] = set_truthTable_by_oneRow_of_kmap(truthTable_left_obj, app_unit_obj.kmap_approximated_obj);
                if(row_isLeaf == 0)
                    app_unit_obj.truthTable_left_obj_output = truthTable_left_obj;
                else
                    truthTable_left_obj = truthTable_class;
                    truthTable_left_obj.input_var_number = 0;
                    app_unit_obj.truthTable_left_obj_output = truthTable_left_obj; % make the left child as leaf
                end

                % second, set the truthTable_right
                truthTable_right_obj = truthTable_class;
                [truthTable_right_obj,app_unit_obj.kmap_approximated_obj,col_isLeaf] = set_truthTable_by_oneCol_of_kmap(truthTable_right_obj, app_unit_obj.kmap_approximated_obj);
                if(col_isLeaf == 0)
                    app_unit_obj.truthTable_right_obj_output = truthTable_right_obj;
                else
                    truthTable_right_obj = truthTable_class;
                    truthTable_right_obj.input_var_number = 0;
                    app_unit_obj.truthTable_right_obj_output = truthTable_right_obj; % make the right child as leaf
                end
            end
        end
        
        function app_unit_obj = set_approximate_unit_helper2(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input)
            % convert this truth table to the kmap
            kmap_obj = kmap_class;
            app_unit_obj.truthTable_obj_input = truthTable_obj_input;
            app_unit_obj.row_var_id_vec_input = row_var_id_vec_input;
            app_unit_obj.col_var_id_vec_input = col_var_id_vec_input;
            row_var_id_vec = row_var_id_vec_input;
            column_var_id_vec = col_var_id_vec_input;
            kmap_obj = set_kmap_by_truthTable(kmap_obj, truthTable_obj_input, column_var_id_vec, row_var_id_vec);
            app_unit_obj.kmap_obj = kmap_obj;

            % get the approximated kmap
            %[kmap_approximate_obj,approximate_error_count] = approximation_core(kmap_obj);
            app_unit_obj.kmap_approximated_obj = kmap_obj;
            
            % set truthTable_left(row vec based) and truthTable_right(col vec based)
            % first, set truthTable_left
%             truthTable_left_obj = truthTable_class;
%             [truthTable_left_obj,app_unit_obj.kmap_approximated_obj] = set_truthTable_by_oneRow_of_kmap(truthTable_left_obj, app_unit_obj.kmap_approximated_obj);
%             app_unit_obj.truthTable_left_obj_output = truthTable_left_obj;
%             
            % second, set the truthTable_right
%             truthTable_right_obj = truthTable_class;
%             [truthTable_right_obj,app_unit_obj.kmap_approximated_obj] = set_truthTable_by_oneCol_of_kmap(truthTable_right_obj, app_unit_obj.kmap_approximated_obj);
%             app_unit_obj.truthTable_right_obj_output = truthTable_right_obj;
        end
    end
end
            
            
            
            
            
            
            
            
            
            


