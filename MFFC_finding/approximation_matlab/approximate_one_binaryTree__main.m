function [error_rate, binaryTree_node_root, is_fully_decomposed, fid] = approximate_one_binaryTree__main(binaryTree_node_root,truthTable_obj, fid, circuit_output_wire_basic_name, circuit_input_wire_names_ordered)

%========================================================================
%                 decompose-approximate-traceback part
% approximate

%binaryTree_node_root = traverse_binaryTree(binaryTree_node_root,truthTable_obj); % for approximation, next we trace back to recover the original truth table

% trace back to get approximated truth table


[binaryTree_node_root,fid] = traceBack_binaryTree(binaryTree_node_root, fid, circuit_output_wire_basic_name, circuit_input_wire_names_ordered);

if(binaryTree_node_root.is_fully_decomposed == 1)
    is_fully_decomposed = 1;
    % eventually get the top-level approximate truth table
    truthTable_unmodified_obj = truthTable_obj;
    truthTable_modified_obj = truthTable_obj;
    kmap_approximated_obj = binaryTree_node_root.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
    truthTable_modified_obj = set_truthTable_by_kmap(truthTable_modified_obj, kmap_approximated_obj);
    binaryTree_node_root.traceBack_unit_obj.truthTable_obj_upper_level_modified = truthTable_modified_obj;
%========================================================================
%                   give the final result


    error_count = sum(truthTable_unmodified_obj.f_vec~=truthTable_modified_obj.f_vec);
    error_rate = error_count / length(truthTable_unmodified_obj.f_vec);
    binaryTree_node_root.approximate_error_rate = error_rate;
    binaryTree_node_root.truth_table_approximated_obj = truthTable_modified_obj;
    binaryTree_node_root.truth_table_obj = truthTable_unmodified_obj;
else
    is_fully_decomposed = 0;
    error_rate = -1;
end