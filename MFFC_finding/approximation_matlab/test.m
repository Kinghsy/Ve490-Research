clear all;
clc;

tree_node_root = tree_node_class;
var_id_vec = [1,2,3,4,5];
is_root = 1;

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





