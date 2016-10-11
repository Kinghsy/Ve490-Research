clear all;
clc;

binaryTree_node_root = binaryTree_node_class;
var_id_vec = [1,2,3,4,5,6];
is_root = 1;

binaryTree_node_root = init_binaryTree_node(binaryTree_node_root,var_id_vec,is_root);

%--------------------------- initialize two children ---------------------
% var_id_vec_left = [1,2,3];
% var_id_vec_right = [4,5,6];
% binaryTree_node_root = add_sub_binaryTree_node_left_right(binaryTree_node_root,var_id_vec_left,var_id_vec_right);

binaryTree_node_root = build_binaryTree_helper(binaryTree_node_root);






% given the truth table
truthTable_obj = truthTable_class;
var_id_vec = [1,2,3,4,5,6];
f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);

binaryTree_node_root = traverse_binaryTree(binaryTree_node_root,truthTable_obj); % for approximation, next we trace back to recover the original truth table


