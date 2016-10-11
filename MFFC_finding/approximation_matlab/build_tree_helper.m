function tree_node_obj = build_tree_helper(tree_node_obj)
if(tree_node_obj.is_leaf == 1)
    return;
else
    n = length(tree_node_obj.var_id_vec);
    for k=1:1:n-1
        left_vec_matrix = nchoosek(tree_node_obj.var_id_vec, k);
        for i=1:1:size(left_vec_matrix,1)
            var_id_vec_left = left_vec_matrix(i,:);
            var_id_vec_right = setdiff(tree_node_obj.var_id_vec,var_id_vec_left);

            tree_node_obj = add_children_tree_branch_obj_vec_of_treeNode(tree_node_obj,var_id_vec_left,var_id_vec_right);
            tree_node_obj.children_tree_branch_obj_vec(end) = add_children_tree_node_left_right_of_branch(tree_node_obj.children_tree_branch_obj_vec(end));
            
            
            
            
            
            tree_node_obj.children_tree_branch_obj_vec(end).child_tree_node_left_obj = build_tree_helper(tree_node_obj.children_tree_branch_obj_vec(end).child_tree_node_left_obj);
            tree_node_obj.children_tree_branch_obj_vec(end).child_tree_node_right_obj = build_tree_helper(tree_node_obj.children_tree_branch_obj_vec(end).child_tree_node_right_obj);

        end
        
        
    end
        
        
        
    % for each left and right sub-tree-node in the vec, build their subtrees.    
        
    
end
    
    
    