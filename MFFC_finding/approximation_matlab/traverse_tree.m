function tree_node_obj = traverse_tree(tree_node_obj)
    if(tree_node_obj.is_leaf == 1)
        return;
    else
        % set app_unit_obj on this level
        app_unit_obj = approximate_unit_class;
        app_unit_obj.is_leaf = 0;

        truthTable_obj_input = tree_node_obj.truth_table_obj;
                
        for i=1:1:length(tree_node_obj.children_tree_branch_obj_vec)
            row_var_id_vec_input = tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.var_id_vec; % row var go to right
            col_var_id_vec_input = tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.var_id_vec; % col var go to left
        
            app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);
            tree_node_obj.children_tree_branch_obj_vec(i).approximate_unit_obj = app_unit_obj;
            
            tree_node_obj.children_tree_branch_obj_vec(i).father_tree_node_obj = tree_node_obj; % not pointer, so need to assign newly
            tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.father_tree_branch_obj = tree_node_obj.children_tree_branch_obj_vec(i);
            tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.father_tree_branch_obj = tree_node_obj.children_tree_branch_obj_vec(i);
                        
            tree_node_obj.children_tree_branch_obj_vec(i) = set_min_error_estimated_current_branch(tree_node_obj.children_tree_branch_obj_vec(i));
        
            if(app_unit_obj.is_leaf == 1)
                tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.is_leaf = 1;
                tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.is_leaf = 1;
            end
            truthTable_obj_input_right = app_unit_obj.truthTable_right_obj_output;
            tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj.truth_table_obj = truthTable_obj_input_right;
            tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj = traverse_tree(tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_right_obj);
            
            truthTable_obj_input_left = app_unit_obj.truthTable_left_obj_output;
            tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj.truth_table_obj = truthTable_obj_input_left;            
            tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj = traverse_tree(tree_node_obj.children_tree_branch_obj_vec(i).child_tree_node_left_obj);
        end
    end
end











