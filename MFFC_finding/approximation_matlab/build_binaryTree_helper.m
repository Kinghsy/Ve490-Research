function binaryTree_node_obj = build_binaryTree_helper(binaryTree_node_obj)
if(binaryTree_node_obj.is_leaf == 1)
    return;
else
    var_id_vec_left = binaryTree_node_obj.var_id_vec(1:2);
    var_id_vec_right = binaryTree_node_obj.var_id_vec(3:end);
    binaryTree_node_obj = add_sub_binaryTree_node_left_right(binaryTree_node_obj,var_id_vec_left,var_id_vec_right);
    
    binaryTree_node_obj.sub_binaryTree_node_left_obj = build_binaryTree_helper(binaryTree_node_obj.sub_binaryTree_node_left_obj);
    binaryTree_node_obj.sub_binaryTree_node_right_obj = build_binaryTree_helper(binaryTree_node_obj.sub_binaryTree_node_right_obj);
end
    
    
    