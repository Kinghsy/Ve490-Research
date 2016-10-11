classdef binaryTree_node_class
    properties
        sub_binaryTree_node_left_obj = [];
        sub_binaryTree_node_right_obj = [];
        father_binaryTree_node_obj = [];        
        var_id_vec = [];
        is_leaf = 0;
        is_root = 0;
        leaf_node_count = 0;
        nonleaf_node_count = 0;
        approximate_error_rate = Inf;
        is_terminal = 0;
        is_fully_decomposed = 1;
        total_LUT_number = 0;
        
        approximate_unit_obj = [];
        traceBack_unit_obj = [];
        truth_table_obj = [];
        truth_table_approximated_obj = [];
        boolean_expression_for_appx_kmap_2x2 = [];
    end
    methods
        function [binaryTree_node_obj,fid] = set_boolean_expression_for_appx_kmap_2x2_by_truthTable_obj(binaryTree_node_obj, fid, output_wire_name, circuit_input_wire_names_ordered)
            % only four elements in the truth table
            f_vec = binaryTree_node_obj.truth_table_obj.f_vec;
            kmap_2x2 = zeros(2,2);
            kmap_2x2(1,1) = f_vec(1);
            kmap_2x2(1,2) = f_vec(2);
            kmap_2x2(2,1) = f_vec(3);
            kmap_2x2(2,2) = f_vec(4);
            
            kmap_obj = kmap_class;
            kmap_obj.row_var_id_vec = binaryTree_node_obj.truth_table_obj.var_id_vec(1);
            kmap_obj.column_var_id_vec = binaryTree_node_obj.truth_table_obj.var_id_vec(2);
            kmap_obj.appx_kmap_2x2 = kmap_2x2;
            left_var_name = ['x',num2str(kmap_obj.column_var_id_vec)];
            right_var_name = ['x',num2str(kmap_obj.row_var_id_vec)];
            [kmap_obj,fid,~,~] = set_boolean_expression_for_appx_kmap_2x2(kmap_obj,fid, output_wire_name, circuit_input_wire_names_ordered);
            binaryTree_node_obj.boolean_expression_for_appx_kmap_2x2 = kmap_obj.boolean_expression_for_appx_kmap_2x2;
        end
            
            
        function binaryTree_node_obj = init_binaryTree_node(binaryTree_node_obj,var_id_vec,is_root)
            binaryTree_node_obj.var_id_vec = var_id_vec;
            binaryTree_node_obj.is_root = is_root;
            if(length(var_id_vec) <= 2)
                binaryTree_node_obj.is_leaf = 1;
            else
                binaryTree_node_obj.is_leaf = 0;
            end
        end
                           
        function father_binaryTree_node_obj = add_sub_binaryTree_node_left_right(father_binaryTree_node_obj,var_id_vec_left,var_id_vec_right)
            sub_binaryTree_node_left_new = binaryTree_node_class;
            sub_binaryTree_node_right_new = binaryTree_node_class;
            
            sub_binaryTree_node_left_new.father_binaryTree_node_obj = father_binaryTree_node_obj;
            sub_binaryTree_node_right_new.father_binaryTree_node_obj = father_binaryTree_node_obj;
            
            sub_binaryTree_node_left_new.var_id_vec = var_id_vec_left;
            sub_binaryTree_node_right_new.var_id_vec = var_id_vec_right;
            
            if(length(var_id_vec_left) <= 2)
                sub_binaryTree_node_left_new.is_leaf = 1;
            end
            if(length(var_id_vec_right) <= 2)
                sub_binaryTree_node_right_new.is_leaf = 1;
            end
    
            father_binaryTree_node_obj.sub_binaryTree_node_left_obj = sub_binaryTree_node_left_new;
            father_binaryTree_node_obj.sub_binaryTree_node_right_obj = sub_binaryTree_node_right_new;
        end
    end
end
    
    