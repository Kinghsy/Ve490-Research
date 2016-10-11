classdef left_right_sub_tree_nodes_set_class
    properties
        tree_node_left_obj;
        tree_node_right_obj;
        father_tree_node_obj;
        is_visited = 0;
        approximate_unit_obj;
        traceBack_unit_obj;
    end
    methods
        function obj = set_is_visited__sub_tree_nodes_set(obj)
            if(obj.tree_node_left_obj.is_visited == 1 && obj.tree_node_right_obj.is_visited == 1)
                obj.is_visited = 1;
            else
                obj.is_visited = 0;
            end
        end
    end
end