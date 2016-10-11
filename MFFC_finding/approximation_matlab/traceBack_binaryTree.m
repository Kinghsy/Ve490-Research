function [binaryTree_node_obj, fid] = traceBack_binaryTree(binaryTree_node_obj, fid, output_wire_name, circuit_input_wire_names_ordered)
    if(binaryTree_node_obj.is_terminal == 1)
        binaryTree_node_obj.is_fully_decomposed = 0;
        input_wire_name_left = [];
        input_wire_name_right = [];
        return;
    end
    if(binaryTree_node_obj.is_leaf == 1)
        if(length(binaryTree_node_obj.var_id_vec) == 2)
            [binaryTree_node_obj, fid] = set_boolean_expression_for_appx_kmap_2x2_by_truthTable_obj(binaryTree_node_obj,fid, output_wire_name, circuit_input_wire_names_ordered);
        end
        return;
    else
        input_wire_name_left = [output_wire_name,'_1'];
        input_wire_name_right = [output_wire_name,'_2'];
        [binaryTree_node_obj.sub_binaryTree_node_left_obj, fid] = traceBack_binaryTree(binaryTree_node_obj.sub_binaryTree_node_left_obj, fid, input_wire_name_left, circuit_input_wire_names_ordered);
        [binaryTree_node_obj.sub_binaryTree_node_right_obj, fid] = traceBack_binaryTree(binaryTree_node_obj.sub_binaryTree_node_right_obj, fid, input_wire_name_right, circuit_input_wire_names_ordered);
        if(binaryTree_node_obj.sub_binaryTree_node_left_obj.is_terminal == 1 || binaryTree_node_obj.sub_binaryTree_node_right_obj.is_terminal == 1)
            binaryTree_node_obj.is_terminal = 1;
        end
        
        
        
          binaryTree_node_obj.traceBack_unit_obj = traceBack_unit_class;
        
%         if(isempty(binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj) == 0)
%             binaryTree_node_obj.sub_binaryTree_node_left_obj.approximate_unit_obj.kmap_approximated_obj = binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
%         end
%         if(isempty(binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj) == 0)        
%             binaryTree_node_obj.sub_binaryTree_node_right_obj.approximate_unit_obj.kmap_approximated_obj = binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
%         end

         sub_app_unit_obj_left = binaryTree_node_obj.sub_binaryTree_node_left_obj.approximate_unit_obj;
         sub_app_unit_obj_right = binaryTree_node_obj.sub_binaryTree_node_right_obj.approximate_unit_obj;

         %flag1 = isempty(binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj)
         %binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj
         if(isempty(binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj) == 0)
            binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj.app_unit_obj.kmap_approximated_obj = binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
            sub_app_unit_obj_left = binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj.app_unit_obj;
         end
         %flag2 = isempty(binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj)
         %binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj
         if(isempty(binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj) == 0)
            binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj.app_unit_obj.kmap_approximated_obj = binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
            sub_app_unit_obj_right = binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj.app_unit_obj;
         end
%         if(isempty(binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj) == 0 && isempty(binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj) == 0)
%             sub_app_unit_obj_left = binaryTree_node_obj.sub_binaryTree_node_left_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
%             sub_app_unit_obj_right = binaryTree_node_obj.sub_binaryTree_node_right_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified;
%         else
%             sub_app_unit_obj_left = binaryTree_node_obj.sub_binaryTree_node_left_obj.approximate_unit_obj;
%             sub_app_unit_obj_right = binaryTree_node_obj.sub_binaryTree_node_right_obj.approximate_unit_obj; 
%         end
        
        app_unit_obj = binaryTree_node_obj.approximate_unit_obj;
        
        [binaryTree_node_obj.traceBack_unit_obj, fid, input_wire_name_left, input_wire_name_right] = set_traceBack_unit(binaryTree_node_obj.traceBack_unit_obj,sub_app_unit_obj_left,sub_app_unit_obj_right,app_unit_obj, fid, output_wire_name, circuit_input_wire_names_ordered);
        binaryTree_node_obj.boolean_expression_for_appx_kmap_2x2 = binaryTree_node_obj.traceBack_unit_obj.app_kmap_obj_upper_level_modified.boolean_expression_for_appx_kmap_2x2;
    
        
%         binaryTree_node_obj.sub_binaryTree_node_left_obj = traceBack_binaryTree(binaryTree_node_obj.sub_binaryTree_node_left_obj);
%         binaryTree_node_obj.sub_binaryTree_node_right_obj = traceBack_binaryTree(binaryTree_node_obj.sub_binaryTree_node_right_obj);
%         if(binaryTree_node_obj.sub_binaryTree_node_left_obj.is_terminal == 1 || binaryTree_node_obj.sub_binaryTree_node_right_obj.is_terminal == 1)
%             binaryTree_node_obj.is_terminal = 1;
%         end
    end
end
            