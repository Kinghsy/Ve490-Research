classdef traceBack_unit_class
    properties
        sub_app_unit_obj_left = [];
        sub_app_unit_obj_right = [];
        app_unit_obj = [];
        
        app_kmap_left_obj_input = [];
        app_kmap_right_obj_input = [];
        
        truthTable_left_obj = [];
        truthTable_right_obj = [];  
        truthTable_obj_upper_level_modified = [];
        
        app_kmap_obj_upper_level = [];
        app_kmap_obj_upper_level_modified = [];
        
    end
    
    methods
        function obj = set_truthTable_obj_upper_level_modified(obj, truthTable_unmodified_obj)
            app_kmap_obj = obj.app_kmap_obj_upper_level_modified;
            kmap_obj = app_kmap_obj.kmap_approximated_obj;
            obj.truthTable_obj_upper_level_modified = set_truthTable_by_kmap(truthTable_unmodified_obj, kmap_obj);
        end
            
        
        function obj = set_traceBack_unit2(obj, sub_app_unit_obj_left, sub_app_unit_obj_right, app_unit_obj)
            
            app_kmap_obj_upper_level = app_unit_obj.kmap_approximated_obj;            
            obj.app_unit_obj = app_unit_obj;            
            obj.app_kmap_obj_upper_level = app_kmap_obj_upper_level;            
            obj.app_kmap_obj_upper_level_modified = app_kmap_obj_upper_level;
            %obj.truthTable_obj_upper_level_modified = set_truthTable_by_kmap(obj.app_unit_obj.truthTable_obj_input, kmap_obj);
            
%            if(isempty(sub_app_unit_obj_left) == 0 || sub_app_unit_obj_left.is_leaf == 0) % if not leaf, then modify the kmap
             if(isempty(sub_app_unit_obj_left) == 0 && sub_app_unit_obj_left.is_leaf == 0) % if not leaf, then modify the kmap
                app_kmap_left_obj_input = sub_app_unit_obj_left.kmap_approximated_obj;

                
                obj.sub_app_unit_obj_left = sub_app_unit_obj_left;
                obj.app_kmap_left_obj_input = app_kmap_left_obj_input;
            
                % set truthTable_left_obj
                truthTable_left_obj = truthTable_class;
                truthTable_left_obj.var_id_vec = [app_kmap_left_obj_input.row_var_id_vec,app_kmap_left_obj_input.column_var_id_vec];
                truthTable_left_obj.input_var_number = length(truthTable_left_obj.var_id_vec);
                
                truthTable_left_obj = set_truthTable_by_kmap(truthTable_left_obj, app_kmap_left_obj_input);
                obj.truthTable_left_obj = truthTable_left_obj;
                
                obj.app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majRows(obj.app_kmap_obj_upper_level_modified, obj.truthTable_left_obj);
                obj.app_unit_obj.kmap_approximated_obj = obj.app_kmap_obj_upper_level_modified;
            end
            
            
            %if(isempty(sub_app_unit_obj_right) == 0 || sub_app_unit_obj_right.is_leaf == 0)
            if(isempty(sub_app_unit_obj_right) == 0 && sub_app_unit_obj_right.is_leaf == 0)
                
                app_kmap_right_obj_input = sub_app_unit_obj_right.kmap_approximated_obj;               
                    
                obj.sub_app_unit_obj_right = sub_app_unit_obj_right;
                obj.app_kmap_right_obj_input = app_kmap_right_obj_input;            
                
                % set truthTable_right_obj
                truthTable_right_obj = truthTable_class;
                %app_kmap_right_obj_input
                %app_kmap_right_obj_input
                truthTable_right_obj.var_id_vec = [app_kmap_right_obj_input.row_var_id_vec,app_kmap_right_obj_input.column_var_id_vec];
                truthTable_right_obj.input_var_number = length(truthTable_right_obj.var_id_vec);
                
                truthTable_right_obj = set_truthTable_by_kmap(truthTable_right_obj, app_kmap_right_obj_input);
                obj.truthTable_right_obj = truthTable_right_obj;
                obj.app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majCols(obj.app_kmap_obj_upper_level_modified, obj.truthTable_right_obj);
                obj.app_unit_obj.kmap_approximated_obj = obj.app_kmap_obj_upper_level_modified;
            end
            
            obj.app_kmap_obj_upper_level_modified = set_appx_kmap_2x2(obj.app_kmap_obj_upper_level_modified);
            [obj.app_kmap_obj_upper_level_modified] = set_boolean_expression_for_appx_kmap_2x2_2(obj.app_kmap_obj_upper_level_modified);
        end
        
        
        
        
        
        
            
        function [obj, fid, input_wire_name_left, input_wire_name_right] = set_traceBack_unit(obj, sub_app_unit_obj_left, sub_app_unit_obj_right, app_unit_obj, fid, output_wire_name, circuit_input_wire_names_ordered)
            
            app_kmap_obj_upper_level = app_unit_obj.kmap_approximated_obj;            
            obj.app_unit_obj = app_unit_obj;            
            obj.app_kmap_obj_upper_level = app_kmap_obj_upper_level;            
            obj.app_kmap_obj_upper_level_modified = app_kmap_obj_upper_level;
            %obj.truthTable_obj_upper_level_modified = set_truthTable_by_kmap(obj.app_unit_obj.truthTable_obj_input, kmap_obj);
            
%            if(isempty(sub_app_unit_obj_left) == 0 || sub_app_unit_obj_left.is_leaf == 0) % if not leaf, then modify the kmap
             if(isempty(sub_app_unit_obj_left) == 0 && sub_app_unit_obj_left.is_leaf == 0) % if not leaf, then modify the kmap
                app_kmap_left_obj_input = sub_app_unit_obj_left.kmap_approximated_obj;

                
                obj.sub_app_unit_obj_left = sub_app_unit_obj_left;
                obj.app_kmap_left_obj_input = app_kmap_left_obj_input;
            
                % set truthTable_left_obj
                truthTable_left_obj = truthTable_class;
                truthTable_left_obj.var_id_vec = [app_kmap_left_obj_input.row_var_id_vec,app_kmap_left_obj_input.column_var_id_vec];
                truthTable_left_obj.input_var_number = length(truthTable_left_obj.var_id_vec);
                
                truthTable_left_obj = set_truthTable_by_kmap(truthTable_left_obj, app_kmap_left_obj_input);
                obj.truthTable_left_obj = truthTable_left_obj;
                
                obj.app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majRows(obj.app_kmap_obj_upper_level_modified, obj.truthTable_left_obj);
                obj.app_unit_obj.kmap_approximated_obj = obj.app_kmap_obj_upper_level_modified;
            end
            
            
            %if(isempty(sub_app_unit_obj_right) == 0 || sub_app_unit_obj_right.is_leaf == 0)
            if(isempty(sub_app_unit_obj_right) == 0 && sub_app_unit_obj_right.is_leaf == 0)
                
                app_kmap_right_obj_input = sub_app_unit_obj_right.kmap_approximated_obj;               
                    
                obj.sub_app_unit_obj_right = sub_app_unit_obj_right;
                obj.app_kmap_right_obj_input = app_kmap_right_obj_input;            
                
                % set truthTable_right_obj
                truthTable_right_obj = truthTable_class;
                %app_kmap_right_obj_input
                %app_kmap_right_obj_input
                truthTable_right_obj.var_id_vec = [app_kmap_right_obj_input.row_var_id_vec,app_kmap_right_obj_input.column_var_id_vec];
                truthTable_right_obj.input_var_number = length(truthTable_right_obj.var_id_vec);
                
                truthTable_right_obj = set_truthTable_by_kmap(truthTable_right_obj, app_kmap_right_obj_input);
                obj.truthTable_right_obj = truthTable_right_obj;
                obj.app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majCols(obj.app_kmap_obj_upper_level_modified, obj.truthTable_right_obj);
                obj.app_unit_obj.kmap_approximated_obj = obj.app_kmap_obj_upper_level_modified;
            end
            
            obj.app_kmap_obj_upper_level_modified = set_appx_kmap_2x2(obj.app_kmap_obj_upper_level_modified);
            [obj.app_kmap_obj_upper_level_modified, fid, input_wire_name_left, input_wire_name_right] = set_boolean_expression_for_appx_kmap_2x2(obj.app_kmap_obj_upper_level_modified, fid, output_wire_name, circuit_input_wire_names_ordered);
        end
    end
end





