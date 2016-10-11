
need_solution_space_generation = 1;

if(need_solution_space_generation == 1)
    clear all;
    clc;
    binaryTree_node_root = binaryTree_node_class;
    var_id_vec = [1,2,3,4,5];
    is_root = 1;
    binaryTree_node_root = init_binaryTree_node(binaryTree_node_root,var_id_vec,is_root);
    binaryTree_node_root = build_binaryTree_helper(binaryTree_node_root);
end

% given the truth table
truthTable_obj = truthTable_class;
%f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);

%========================================================================
% binaryTree part

is_root = 1;
tree_node_root = tree_node_class;
tree_node_root = init_tree_node(tree_node_root,var_id_vec,is_root);
tree_node_root = build_tree_helper(tree_node_root);
tree_node_root_test = tree_node_root;

binaryTree_node_root_record = [];
while(tree_node_root_test.is_visited == 0)
    binaryTree_node_root = binaryTree_node_class;
    [tree_node_root_test, binaryTree_node_root] = extract_binaryTrees(tree_node_root_test, binaryTree_node_root);
    binaryTree_node_root_record = [binaryTree_node_root_record,binaryTree_node_root];
end

length(binaryTree_node_root_record)

error_rate_record = [];
for i=1:1:length(binaryTree_node_root_record)
    i
    binaryTree_node_root = binaryTree_node_root_record(i);
    error_rate = approximate_one_truthTable__main(binaryTree_node_root,truthTable_obj)
    error_rate_record = [error_rate_record, error_rate];
end


% too long run time occurs at i=391 (too many dont-cares)

min_error_rate = min(error_rate_record)




