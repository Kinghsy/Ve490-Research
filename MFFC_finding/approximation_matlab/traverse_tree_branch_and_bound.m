function tree_node_obj = traverse_tree_branch_and_bound(tree_node_obj, enable_fast_mode, dont_care_upper_bound)
    error_bound = Inf;
    if(tree_node_obj.is_leaf == 1)
        tree_node_obj.chosen_child_tree_branch_obj = tree_branch_class;        
        return;
    else        

        truthTable_obj_input = tree_node_obj.truth_table_obj;
                
        for i=1:1:length(tree_node_obj.children_tree_branch_obj_vec)
            %error_bound
            row_var_id_vec_input = tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.var_id_vec; % row var go to right
            col_var_id_vec_input = tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.var_id_vec; % col var go to left
        % set app_unit_obj on this level
            app_unit_obj = approximate_unit_class;
            app_unit_obj.is_leaf = 0;
            
            app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input, enable_fast_mode, dont_care_upper_bound);
            tree_node_obj.children_tree_branch_obj_vec(i).approximate_unit_obj = app_unit_obj;            
            appx_error = tree_node_obj.children_tree_branch_obj_vec(i).approximate_unit_obj.approximate_error_bit_count;
            if(appx_error > error_bound)
                %disp('yes');
                tree_node_obj.children_tree_branch_obj_vec(i).is_terminal = 1;
                continue;
            else
                
%                 tree_node_obj.children_tree_branch_obj_vec(i).father_tree_node_obj = tree_node_obj; % not pointer, so need to assign newly
%                 tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.father_tree_branch_obj = tree_node_obj.children_tree_branch_obj_vec(i);
%                 tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.father_tree_branch_obj = tree_node_obj.children_tree_branch_obj_vec(i);
% 
%                 %tree_node_obj.children_tree_branch_obj_vec(i) = set_min_error_estimated_current_branch(tree_node_obj.children_tree_branch_obj_vec(i));

                if(app_unit_obj.is_leaf == 1)
                    tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.is_leaf = 1;
                    tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.is_leaf = 1;
                end
                
                truthTable_obj_input_right = app_unit_obj.truthTable_right_obj_output;
                tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.truth_table_obj = truthTable_obj_input_right;
                tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj = traverse_tree_branch_and_bound(tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj, enable_fast_mode, dont_care_upper_bound);

                truthTable_obj_input_left = app_unit_obj.truthTable_left_obj_output;
                tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.truth_table_obj = truthTable_obj_input_left;            
                tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj = traverse_tree_branch_and_bound(tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj, enable_fast_mode, dont_care_upper_bound);
            
                % from current approximate error, sub-left-error and
                % sub-right-error, get the current error, and update the
                % error_bound or continue
                
                % set the traceBack_unit_obj
                traceBack_unit_obj = traceBack_unit_class;
           
                sub_app_unit_obj_left = tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.chosen_child_tree_branch_obj.approximate_unit_obj;
                sub_app_unit_obj_right = tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.chosen_child_tree_branch_obj.approximate_unit_obj;
                app_unit_obj = tree_node_obj.children_tree_branch_obj_vec(i).approximate_unit_obj;
                traceBack_unit_obj = set_traceBack_unit2(traceBack_unit_obj,sub_app_unit_obj_left,sub_app_unit_obj_right,app_unit_obj);
                %disp('--------------------');
                %tree_node_obj.children_tree_branch_obj_vec(i).approximate_unit_obj.kmap_obj.kmap
                %traceBack_unit_obj.app_kmap_obj_upper_level_modified.kmap
                exact_error_bit_count = sum(sum(traceBack_unit_obj.app_kmap_obj_upper_level_modified.kmap ~= tree_node_obj.children_tree_branch_obj_vec(i).approximate_unit_obj.kmap_obj.kmap));
                %exact_error_bit_count
                if(exact_error_bit_count < error_bound)
                    error_bound = exact_error_bit_count;
                    tree_node_obj.chosen_child_tree_branch_obj = tree_node_obj.children_tree_branch_obj_vec(i);
                else
                    %disp('yes');
                    tree_node_obj.children_tree_branch_obj_vec(i).is_terminal = 1;
                    continue;
                end
            end
        end
    end
end











