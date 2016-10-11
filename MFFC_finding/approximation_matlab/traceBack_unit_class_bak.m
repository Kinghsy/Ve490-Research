classdef traceBack_unit_class
    properties
        sub_app_unit_obj_left;
        sub_app_unit_obj_right;
        app_unit_obj;
        
        app_kmap_left_obj_input;
        app_kmap_right_obj_input;
        
        truthTable_left_obj;
        truthTable_right_obj;
        
        app_kmap_obj_upper_level;
        app_kmap_obj_upper_level_modified;
        
    end
    
    methods
        function [obj, app_unit_obj] = set_traceBack_unit(obj,sub_app_unit_obj_left,sub_app_unit_obj_right,app_unit_obj)
            obj.sub_app_unit_obj_left = sub_app_unit_obj_left;
            obj.sub_app_unit_obj_right = sub_app_unit_obj_right;
            obj.app_unit_obj = app_unit_obj;
            app_kmap_left_obj_input = sub_app_unit_obj_left.kmap_approximated_obj;
            app_kmap_right_obj_input = sub_app_unit_obj_right.kmap_approximated_obj;
            app_kmap_obj_upper_level = app_unit_obj;
            %obj = set_traceBack_unit_helper(obj,app_kmap_left_obj_input,app_kmap_right_obj_input,app_kmap_obj_upper_level);
            
        
            obj.app_kmap_left_obj_input = app_kmap_left_obj_input;
            obj.app_kmap_right_obj_input = app_kmap_right_obj_input;
            obj.app_kmap_obj_upper_level = app_kmap_obj_upper_level;
       
            % use "truthTable_left_obj" to modify
            % "app_kmap_obj_upper_level" maj rows, use "truthTable_right_obj" to modify
            % "app_kmap_obj_upper_level" maj cols
            obj.app_kmap_obj_upper_level_modified = app_kmap_obj_upper_level;
            app_kmap_obj_upper_level_modified = obj.app_kmap_obj_upper_level_modified;
            
            if(sub_app_unit_obj_left.is_leaf == 0) % if not leaf, then modify the kmap
                % set truthTable_left_obj
                truthTable_left_obj = truthTable_class;
                truthTable_left_obj.var_id_vec = [app_kmap_left_obj_input.row_var_id_vec,app_kmap_left_obj_input.column_var_id_vec];
                truthTable_left_obj.input_var_number = length(truthTable_left_obj.var_id_vec);

                truthTable_left_obj = set_truthTable_by_kmap(truthTable_left_obj, app_kmap_left_obj_input);
                obj.truthTable_left_obj = truthTable_left_obj;
                app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majRows(app_kmap_obj_upper_level_modified,truthTable_left_obj);
            end
            if(sub_app_unit_obj_right.is_leaf == 0)
                 % set truthTable_right_obj
                truthTable_right_obj = truthTable_class;
                truthTable_right_obj.var_id_vec = [app_kmap_right_obj_input.row_var_id_vec,app_kmap_right_obj_input.column_var_id_vec];
                truthTable_right_obj.input_var_number = length(truthTable_right_obj.var_id_vec);

                truthTable_right_obj = set_truthTable_by_kmap(truthTable_right_obj, app_kmap_right_obj_input);
                obj.truthTable_right_obj = truthTable_right_obj;
                app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majCols(app_kmap_obj_upper_level_modified,truthTable_right_obj);
            end
            
            obj.app_kmap_obj_upper_level_modified = app_kmap_obj_upper_level_modified;
            app_unit_obj.kmap_approximated_obj = obj.app_kmap_obj_upper_level_modified;
     
        end
        
        
%         function obj = set_traceBack_unit_helper(obj,app_kmap_left_obj_input,app_kmap_right_obj_input,app_kmap_obj_upper_level)
%             obj.app_kmap_left_obj_input = app_kmap_left_obj_input;
%             obj.app_kmap_right_obj_input = app_kmap_right_obj_input;
%             obj.app_kmap_obj_upper_level = app_kmap_obj_upper_level;
%         
%             % set truthTable_left_obj
%             truthTable_left_obj = truthTable_class;
%             truthTable_left_obj.var_id_vec = [app_kmap_left_obj_input.row_var_id_vec,app_kmap_left_obj_input.column_var_id_vec];
%             truthTable_left_obj.input_var_number = length(truthTable_left_obj.var_id_vec);
%             
%             truthTable_left_obj = set_truthTable_by_kmap(truthTable_left_obj, app_kmap_left_obj_input);
%             obj.truthTable_left_obj = truthTable_left_obj;
%         
%             % set truthTable_right_obj
%             truthTable_right_obj = truthTable_class;
%             truthTable_right_obj.var_id_vec = [app_kmap_right_obj_input.row_var_id_vec,app_kmap_right_obj_input.column_var_id_vec];
%             truthTable_right_obj.input_var_number = length(truthTable_right_obj.var_id_vec);
%             
%             truthTable_right_obj = set_truthTable_by_kmap(truthTable_right_obj, app_kmap_right_obj_input);
%             obj.truthTable_right_obj = truthTable_right_obj;
%         
%             % use "truthTable_left_obj" to modify
%             % "app_kmap_obj_upper_level" maj rows, use "truthTable_right_obj" to modify
%             % "app_kmap_obj_upper_level" maj cols
%             obj.app_kmap_obj_upper_level_modified = app_kmap_obj_upper_level;
%             
%             obj.app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majRows(obj.app_kmap_obj_upper_level_modified,obj.truthTable_left_obj);
%             obj.app_kmap_obj_upper_level_modified = use_truthTable_modify_kmap_majCols(obj.app_kmap_obj_upper_level_modified,obj.truthTable_right_obj);
%             
%         end
    end
end
            
            
            
            
            
        