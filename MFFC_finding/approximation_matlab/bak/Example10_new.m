
%need_solution_space_generation = 1;

%if(need_solution_space_generation == 1)
clear all;
clc;
binaryTree_node_root = binaryTree_node_class;
var_id_vec = [1,2,3,4,5];
is_root = 1;
binaryTree_node_root = init_binaryTree_node(binaryTree_node_root,var_id_vec,is_root);
binaryTree_node_root = build_binaryTree_helper(binaryTree_node_root);
%end

% given the truth table
truthTable_obj = truthTable_class;
%rng('default');
seed = 0; % seed=1, good test, 295 solutions, after approximate, all 0's or all 1's kmap occurs
rand('seed',seed);
f_vec = (rand(1,2^length(var_id_vec)) > 0.5)
%f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];

f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);

%========================================================================
% binaryTree part

is_root = 1;
tree_node_root = tree_node_class;
tree_node_root = init_tree_node(tree_node_root,var_id_vec,is_root);
tree_node_root = build_tree_helper(tree_node_root);
disp('tree_node_root building finished! Start to traverse tree...');

tic;
tree_node_root.truth_table_obj = truthTable_obj;
tree_node_root = traverse_tree(tree_node_root);
disp('Traversing tree finished!');
traversing_time = toc

%disp('Traversing tree finished! Start to trace back the tree...');

% traceBack_tree needs more thinking!!!
%tree_node_root = traceBack_tree(tree_node_root);

disp('Start binary tree extraction...');

tree_node_root_test = tree_node_root;

binaryTree_node_root_record = [];
while(tree_node_root_test.is_visited == 0)
    binaryTree_node_root = binaryTree_node_class;
    [tree_node_root_test, binaryTree_node_root] = extract_binaryTrees(tree_node_root_test, binaryTree_node_root);
    binaryTree_node_root_record = [binaryTree_node_root_record,binaryTree_node_root];
end

disp('Binary tree extraction finishes! Starts trace back...');

error_rate_record = [];
error_rate_min = Inf;
for i=1:1:length(binaryTree_node_root_record)
    i
    binaryTree_node_root = binaryTree_node_root_record(i);    
    [error_rate, binaryTree_node_root] = approximate_one_binaryTree__main(binaryTree_node_root,truthTable_obj);
    if(error_rate < error_rate_min)
        error_rate_min = error_rate;
        error_rate_min_index = i;
    end
    binaryTree_node_root_record(i) = binaryTree_node_root;
    error_rate_record = [error_rate_record, error_rate];
end
min_error_rate = min(error_rate_record)
binaryTree_node_root_minError = binaryTree_node_root_record(error_rate_min_index);



% tree_node_root_test = tree_node_root;
%
% binaryTree_node_root_record = [];
% while(tree_node_root_test.is_visited == 0)
%     binaryTree_node_root = binaryTree_node_class;
%     [tree_node_root_test, binaryTree_node_root] = extract_binaryTrees(tree_node_root_test, binaryTree_node_root);
%     binaryTree_node_root_record = [binaryTree_node_root_record,binaryTree_node_root];
% end
%
% length(binaryTree_node_root_record)
%
% error_rate_record = [];
% for i=1:1:length(binaryTree_node_root_record)
%     i
%     binaryTree_node_root = binaryTree_node_root_record(i);
%     error_rate = approximate_one_truthTable__main(binaryTree_node_root,truthTable_obj)
%     error_rate_record = [error_rate_record, error_rate];
% end
%
%
% % too long run time occurs at i=391 (too many dont-cares)
%
% min_error_rate = min(error_rate_record)




