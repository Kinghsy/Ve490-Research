classdef tree_node_class
    properties
        children_tree_branch_obj_vec = [];
        chosen_child_tree_branch_obj = [];
        var_id_vec = [];
        father_tree_branch_obj;
        is_leaf = 0;
        is_root = 0;
        is_visited = 0;
        is_on_left = 0; % 0: is on right, 1: is on left
 
        truth_table_obj;
        traceBack_unit_obj;
    end
    methods
        
          
%         function index = find_min_approximateError_obj_index(obj)
%             index = 0;
%             min_error = Inf;
%             length1 = length(obj.left_right_sub_tree_nodes_set_vec)
%             for i=1:1:length(obj.left_right_sub_tree_nodes_set_vec)
%                 kmap_original = obj.left_right_sub_tree_nodes_set_vec(i).approximate_unit_obj.kmap_obj.kmap;
%                 kmap_approximate = obj.left_right_sub_tree_nodes_set_vec(i).approximate_unit_obj.kmap_approximated_obj.kmap;
%                 error_count = sum(sum(kmap_original~=kmap_approximate))
%                 if(error_count < min_error)
%                     index = i;
%                     min_error = error_count;
%                 end
%             end
%         end        
            
            
            
            
        function [obj,left_right_sub_tree_nodes_set__fist_not_visited__index] = get_left_right_sub_tree_nodes_set__fist_not_visited(obj)
            left_right_sub_tree_nodes_set_vec = obj.left_right_sub_tree_nodes_set_vec;
            for i=1:1:length(left_right_sub_tree_nodes_set_vec)
                left_right_sub_tree_nodes_set = left_right_sub_tree_nodes_set_vec(i);
                if(left_right_sub_tree_nodes_set.is_visited == 0)
                    left_right_sub_tree_nodes_set__fist_not_visited__index = i;
                    %obj.left_right_sub_tree_nodes_set_vec(i).is_visited = 1;
                    return;
                end
            end
        end
        
        function [obj,first_branch_obj_not_visited_index] = get_first_branch_obj_not_visited(obj)
            children_tree_branch_obj_vec = obj.children_tree_branch_obj_vec;
            for i=1:1:length(children_tree_branch_obj_vec)
                children_tree_branch_obj = children_tree_branch_obj_vec(i);
                if(children_tree_branch_obj.is_visited == 0)
                    first_branch_obj_not_visited_index = i;
                    %obj.left_right_sub_tree_nodes_set_vec(i).is_visited = 1;
                    return;
                end
            end
        end
        
        function tree_node_obj = set_is_visited__tree_node(tree_node_obj)
            count_children_tree_branch_obj_vec = length(tree_node_obj.children_tree_branch_obj_vec);
            for i=1:1:count_children_tree_branch_obj_vec
                if(tree_node_obj.children_tree_branch_obj_vec(i).is_visited == 0)
                    tree_node_obj.is_visited = 0;
                    return;
                end
            end
            tree_node_obj.is_visited = 1; % all the sub-trees are visited, then this node is visited
            return;
        end
        
        
        function tree_node_obj = init_tree_node(tree_node_obj,var_id_vec,is_root)
            tree_node_obj.var_id_vec = var_id_vec;
            tree_node_obj.is_root = is_root;
            if(length(var_id_vec) <= 2)
                tree_node_obj.is_leaf = 1;
            else
                tree_node_obj.is_leaf = 0;
            end
        end
           
        
        
        function father_tree_node_obj = add_children_tree_branch_obj_vec_of_treeNode(father_tree_node_obj,var_id_vec_left,var_id_vec_right)
%             if(father_tree_node_obj.is_leaf == 1)
%                 return;
%             end
            child_tree_branch_new = tree_branch_class;
            
            child_tree_branch_new.father_tree_node_obj = father_tree_node_obj;
            
            child_tree_branch_new.var_id_vec_right = var_id_vec_right;
            child_tree_branch_new.var_id_vec_left = var_id_vec_left;
            
            father_tree_node_obj.children_tree_branch_obj_vec = [father_tree_node_obj.children_tree_branch_obj_vec,child_tree_branch_new];
        end
    end
end
    
    