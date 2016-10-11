function [tree_node_root, binaryTree_node_root] = extract_optimal_binaryTrees_BranchAndBound(tree_node_root, binaryTree_node_root)
binaryTree_node_root.truth_table_obj = tree_node_root.truth_table_obj;
binaryTree_node_root.traceBack_unit_obj = tree_node_root.traceBack_unit_obj;

if(tree_node_root.is_leaf == 1)
    binaryTree_node_root.var_id_vec = tree_node_root.var_id_vec;
    binaryTree_node_root.is_leaf = 1;
    binaryTree_node_root.is_root = 0;    
    
    return;
else
    binaryTree_node_root.var_id_vec = tree_node_root.var_id_vec;
    binaryTree_node_root.is_leaf = tree_node_root.is_leaf;
    binaryTree_node_root.is_root = tree_node_root.is_root;
    %binaryTree_node_root.is_terminal = tree_node_root.chosen_child_tree_branch_obj.is_terminal;
    
        binaryTree_node_root.approximate_unit_obj = tree_node_root.chosen_child_tree_branch_obj.approximate_unit_obj;    
       
        binaryTree_node_root.sub_binaryTree_node_left_obj = binaryTree_node_class;
        binaryTree_node_root.sub_binaryTree_node_right_obj = binaryTree_node_class;
    
        binaryTree_node_root.sub_binaryTree_node_left_obj.father_binaryTree_node_obj = binaryTree_node_root;
        binaryTree_node_root.sub_binaryTree_node_right_obj.father_binaryTree_node_obj = binaryTree_node_root;
    
        binaryTree_node_root.sub_binaryTree_node_left_obj.var_id_vec = tree_node_root.chosen_child_tree_branch_obj.child_tree_node_left_obj.var_id_vec;
        binaryTree_node_root.sub_binaryTree_node_right_obj.var_id_vec = tree_node_root.chosen_child_tree_branch_obj.child_tree_node_right_obj.var_id_vec;
    
        [tree_node_root.chosen_child_tree_branch_obj.child_tree_node_left_obj, binaryTree_node_root.sub_binaryTree_node_left_obj] = extract_optimal_binaryTrees_BranchAndBound(tree_node_root.chosen_child_tree_branch_obj.child_tree_node_left_obj, binaryTree_node_root.sub_binaryTree_node_left_obj);
    	[tree_node_root.chosen_child_tree_branch_obj.child_tree_node_right_obj, binaryTree_node_root.sub_binaryTree_node_right_obj] = extract_optimal_binaryTrees_BranchAndBound(tree_node_root.chosen_child_tree_branch_obj.child_tree_node_right_obj, binaryTree_node_root.sub_binaryTree_node_right_obj);
end
    
    
    
    
    
    
    
    