function tree_node_obj = traceBack_tree(tree_node_obj)
if(tree_node_obj.is_leaf == 1)
    return;
else
    for i=1:1:length(tree_node_obj.left_right_sub_tree_nodes_set_vec)
        
        tree_node_obj.left_right_sub_tree_nodes_set_vec(i).traceBack_unit_obj = traceBack_unit_class;
        
        % choose the one with least error
        index_left = find_min_approximateError_obj_index(tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_left_obj)
        sub_app_unit_obj_left = tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_left_obj.left_right_sub_tree_nodes_set_vec(index_left).approximate_unit_obj;
        
        index_right = find_min_approximateError_obj_index(tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_right_obj);
        sub_app_unit_obj_right = tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_left_obj.left_right_sub_tree_nodes_set_vec(index_right).approximate_unit_obj;
        
        % -------------------------------
        
        app_unit_obj = tree_node_obj.left_right_sub_tree_nodes_set_vec(i).approximate_unit_obj;
        
        tree_node_obj.left_right_sub_tree_nodes_set_vec(i).traceBack_unit_obj = set_traceBack_unit(tree_node_obj.left_right_sub_tree_nodes_set_vec(i).traceBack_unit_obj,sub_app_unit_obj_left,sub_app_unit_obj_right,app_unit_obj);
        
        tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_left_obj = traceBack_binaryTree(tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_left_obj);
        tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_right_obj = traceBack_binaryTree(tree_node_obj.left_right_sub_tree_nodes_set_vec(i).tree_node_right_obj);
    end
end


