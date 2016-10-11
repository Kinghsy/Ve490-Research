function tree_branch_obj = get_current_tree_branch_min_error_estimated_helper(tree_branch_obj)
if(tree_branch_obj.father_tree_node_obj.is_root == 1)    
    %min_error_estimated = tree_branch_obj.approximate_unit_obj.approximate_error_bit_count;
    tree_branch_obj.min_error_estimated = tree_branch_obj.approximate_unit_obj.approximate_error_bit_count;
    return;
else
    father_tree_branch_obj = tree_branch_obj.father_tree_node_obj.father_tree_branch_obj;
    maj_row_vec_count = father_tree_branch_obj.approximate_unit_obj.kmap_approximated_obj.majority_row_vec_count;
    maj_col_vec_count = father_tree_branch_obj.approximate_unit_obj.kmap_approximated_obj.majority_col_vec_count;
    is_on_left = tree_branch_obj.father_tree_node_obj.is_on_left;
    %approximate_error_count_current_tree_branch = tree_branch_obj.approximate_unit_obj.approximate_error_bit_count;
    %approximate_error_count_father_tree_branch = father_tree_branch_obj.approximate_unit_obj.approximate_error_bit_count;
    
    father_tree_branch_obj = get_current_tree_branch_min_error_estimated_helper(father_tree_branch_obj);
    if(is_on_left == 1) % on left, maj_row_vec
        tree_branch_obj.min_error_estimated = father_tree_branch_obj.min_error_estimated + maj_row_vec_count * tree_branch_obj.approximate_unit_obj.approximate_error_bit_count;
      
    else
        tree_branch_obj.min_error_estimated = father_tree_branch_obj.min_error_estimated + maj_col_vec_count * tree_branch_obj.approximate_unit_obj.approximate_error_bit_count;
    end
end
    






