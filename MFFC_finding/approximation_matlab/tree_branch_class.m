classdef tree_branch_class % definition of tree_branch see 24Nov 2015 note
    properties
        var_id_vec_left;
        var_id_vec_right;
        child_tree_node_left_obj;
        child_tree_node_right_obj;
        father_tree_node_obj;
        approximate_unit_obj = [];
        is_visited = 0;
        is_terminal = 0;
        min_error_estimated = 0;
    end
    methods
        function obj = set_min_error_estimated_current_branch(obj)
            obj.min_error_estimated = obj.approximate_unit_obj.approximate_error_bit_count;
            obj = get_current_tree_branch_min_error_estimated_helper(obj);
        end
        function obj = add_children_tree_node_left_right_of_branch(obj)
            obj.child_tree_node_left_obj = tree_node_class;
            var_id_vec = obj.var_id_vec_left;
            is_root = 0;
            obj.child_tree_node_left_obj = init_tree_node(obj.child_tree_node_left_obj,var_id_vec,is_root);
            obj.child_tree_node_left_obj.father_tree_branch_obj = obj;
            obj.child_tree_node_left_obj.is_on_left = 1;
            
            obj.child_tree_node_right_obj = tree_node_class;
            var_id_vec = obj.var_id_vec_right;
            is_root = 0;
            obj.child_tree_node_right_obj = init_tree_node(obj.child_tree_node_right_obj,var_id_vec,is_root);
            obj.child_tree_node_right_obj.father_tree_branch_obj = obj;
            obj.child_tree_node_right_obj.is_on_left = 0;
            
        end
    end
end
        
        
        
        
        
        
        