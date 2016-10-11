function [tree_node_root, binaryTree_node_root] = extract_binaryTrees(tree_node_root, binaryTree_node_root)
if(tree_node_root.is_leaf == 1)
    binaryTree_node_root.var_id_vec = tree_node_root.var_id_vec;
    binaryTree_node_root.is_leaf = tree_node_root.is_leaf;
    binaryTree_node_root.is_root = tree_node_root.is_root;
    tree_node_root.is_visited = 1;
else
    binaryTree_node_root.var_id_vec = tree_node_root.var_id_vec;
    binaryTree_node_root.is_leaf = tree_node_root.is_leaf;
    binaryTree_node_root.is_root = tree_node_root.is_root;
    %binaryTree_node_root.is_terminal = tree_node_root.chosen_child_tree_branch_obj.is_terminal;
    
    
    if(tree_node_root.is_visited == 0)
        % choose the first one not visited yet
        [tree_node_root, first_branch_obj_not_visited_index] = get_first_branch_obj_not_visited(tree_node_root);
       
        binaryTree_node_root.is_terminal = tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).is_terminal;
        
        binaryTree_node_root.approximate_unit_obj = tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).approximate_unit_obj;    
       
        binaryTree_node_root.sub_binaryTree_node_left_obj = binaryTree_node_class;
        binaryTree_node_root.sub_binaryTree_node_right_obj = binaryTree_node_class;
    
        binaryTree_node_root.sub_binaryTree_node_left_obj.father_binaryTree_node_obj = binaryTree_node_root;
        binaryTree_node_root.sub_binaryTree_node_right_obj.father_binaryTree_node_obj = binaryTree_node_root;
    
        binaryTree_node_root.sub_binaryTree_node_left_obj.var_id_vec = tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_left_obj.var_id_vec;
        binaryTree_node_root.sub_binaryTree_node_right_obj.var_id_vec = tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_right_obj.var_id_vec;
    
        [tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_left_obj, binaryTree_node_root.sub_binaryTree_node_left_obj] = extract_binaryTrees(tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_left_obj, binaryTree_node_root.sub_binaryTree_node_left_obj);
    	[tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_right_obj, binaryTree_node_root.sub_binaryTree_node_right_obj] = extract_binaryTrees(tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_right_obj, binaryTree_node_root.sub_binaryTree_node_right_obj);

        
        if(tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_left_obj.is_visited == 1 && tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).child_tree_node_right_obj.is_visited == 1)
            tree_node_root.children_tree_branch_obj_vec(first_branch_obj_not_visited_index).is_visited = 1;
        end

    end
    tree_node_root = set_is_visited__tree_node(tree_node_root);
    
end
    
    
    
    
    
    
    
    