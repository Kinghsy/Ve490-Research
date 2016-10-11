function [leaf_node_count, nonleaf_node_count] = counting_binary_tree_nodes(binaryTreeNode_obj, leaf_node_count, nonleaf_node_count)
if(binaryTreeNode_obj.is_leaf == 1)
    leaf_node_count = leaf_node_count + 1;
    return;
else
    [leaf_node_count_left, nonleaf_node_count_left] = counting_binary_tree_nodes(binaryTreeNode_obj.sub_binaryTree_node_left_obj, leaf_node_count, nonleaf_node_count);
    [leaf_node_count_right, nonleaf_node_count_right] = counting_binary_tree_nodes(binaryTreeNode_obj.sub_binaryTree_node_right_obj, leaf_node_count, nonleaf_node_count);
    nonleaf_node_count = nonleaf_node_count + nonleaf_node_count_left + nonleaf_node_count_right + 1;
    leaf_node_count = leaf_node_count + leaf_node_count_left + leaf_node_count_right;
end







