function binaryTree_node_obj = traverse_binaryTree(binaryTree_node_obj,truthTable_obj_input)
    %if(get_is_all_1s(truthTable_obj_input.f_vec) == 1 || get_is_all_0s(truthTable_obj_input.f_vec) == 1 || binaryTree_node_obj.is_leaf == 1)
    if(binaryTree_node_obj.is_leaf == 1)
        app_unit_obj = approximate_unit_class;
        app_unit_obj.is_leaf = 1;
        binaryTree_node_obj.approximate_unit_obj = app_unit_obj;
    else
        % set app_unit_obj on this level
        app_unit_obj = approximate_unit_class;
        app_unit_obj.is_leaf = 0;
        %truthTable_obj_input = binaryTree_node_obj.approximate_unit_obj.truthTable_obj_input;
        
        row_var_id_vec_input = binaryTree_node_obj.sub_binaryTree_node_right_obj.var_id_vec; % row var go to right
        col_var_id_vec_input = binaryTree_node_obj.sub_binaryTree_node_left_obj.var_id_vec; % col var go to left
        
        %truthTable_obj_input_f_vec = truthTable_obj_input.f_vec
        app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);
        binaryTree_node_obj.approximate_unit_obj = app_unit_obj;

        truthTable_obj_input_right = app_unit_obj.truthTable_right_obj_output;
        %truthTable_obj_input_right_f_vec = truthTable_obj_input_right.f_vec
        binaryTree_node_obj.sub_binaryTree_node_right_obj = traverse_binaryTree(binaryTree_node_obj.sub_binaryTree_node_right_obj,truthTable_obj_input_right);
        truthTable_obj_input_left = app_unit_obj.truthTable_left_obj_output;
        binaryTree_node_obj.sub_binaryTree_node_left_obj = traverse_binaryTree(binaryTree_node_obj.sub_binaryTree_node_left_obj,truthTable_obj_input_left);
    end
end











