% debug test1, 6 vars, f has 64 bits
clear all;
close all;
clc;


% given the truth table
var_count = 6;
var_id_vec = [1,2,3,4,5,6];
truthTable_obj = truthTable_class;
rng('default');
%f_vec = (rand(1,2^var_count)>0.5);
f_vec = zeros(1,2^var_count); % all 1s,or all 0s will result in error!!!
f_vec(1) = 1;

f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);
truthTable_obj
%========================================================================
% binaryTree part


binaryTree_node_root = binaryTree_node_class;

% build binary tree
% level1
is_root = 1;
binaryTree_node_root = init_binaryTree_node(binaryTree_node_root,var_id_vec,is_root);

% level 2
var_id_vec_left = [1,2,3];
var_id_vec_right = [4,5,6];
binaryTree_node_root = add_sub_binaryTree_node_left_right(binaryTree_node_root,var_id_vec_left,var_id_vec_right);            

% level 3
var_id_vec_left1 = [1,2];
var_id_vec_right1 = [3];
binaryTree_node_root.sub_binaryTree_node_left_obj = add_sub_binaryTree_node_left_right(binaryTree_node_root.sub_binaryTree_node_left_obj,var_id_vec_left1,var_id_vec_right1);           

var_id_vec_left2 = [4,5];
var_id_vec_right2 = [6];
binaryTree_node_root.sub_binaryTree_node_right_obj = add_sub_binaryTree_node_left_right(binaryTree_node_root.sub_binaryTree_node_right_obj,var_id_vec_left2,var_id_vec_right2);           




    
[error_rate,binaryTree_node_root] = approximate_one_truthTable__main(binaryTree_node_root,truthTable_obj)





