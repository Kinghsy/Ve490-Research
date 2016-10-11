function binaryTree_node_root = extract_one_binaryTree(tree_node_root, binaryTree_node_root)
if(tree_node_root.is_leaf == 1)
    binaryTree_node_root.var_id_vec = tree_node_root.var_id_vec;
    binaryTree_node_root.is_leaf = tree_node_root.is_leaf;
    binaryTree_node_root.is_root = tree_node_root.is_root;
    
else
    binaryTree_node_root.var_id_vec = tree_node_root.var_id_vec;
    binaryTree_node_root.is_leaf = tree_node_root.is_leaf;
    binaryTree_node_root.is_root = tree_node_root.is_root;
    
    
    left_right_sub_tree_nodes_set = tree_node_root.left_right_sub_tree_nodes_set_vec(1);
    binaryTree_node_root.sub_binaryTree_node_left_obj = binaryTree_node_class;
    binaryTree_node_root.sub_binaryTree_node_right_obj = binaryTree_node_class;
    
    binaryTree_node_root.sub_binaryTree_node_left_obj.father_binaryTree_node_obj = binaryTree_node_root;
    binaryTree_node_root.sub_binaryTree_node_right_obj.father_binaryTree_node_obj = binaryTree_node_root;
    
    binaryTree_node_root.sub_binaryTree_node_left_obj.var_id_vec = left_right_sub_tree_nodes_set.tree_node_left_obj.var_id_vec;
    binaryTree_node_root.sub_binaryTree_node_right_obj.var_id_vec = left_right_sub_tree_nodes_set.tree_node_right_obj.var_id_vec;
    
    [binaryTree_node_root.sub_binaryTree_node_left_obj] = extract_one_binaryTree(left_right_sub_tree_nodes_set.tree_node_left_obj, binaryTree_node_root.sub_binaryTree_node_left_obj);
    [binaryTree_node_root.sub_binaryTree_node_right_obj] = extract_one_binaryTree(left_right_sub_tree_nodes_set.tree_node_right_obj, binaryTree_node_root.sub_binaryTree_node_right_obj);
end
    
    
    
    
    
    
    
    
    