clear;
clc;

% given the truth table
truthTable_obj = truthTable_class;
var_id_vec = [1,2,3,4,5,6];
f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);


app_unit_obj = approximate_unit_class;
truthTable_obj_input = truthTable_obj;
row_var_id_vec_input = [4,5,6]; % row var go to right
col_var_id_vec_input = [1,2,3]; % col var go to left
app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

app_unit_obj

%-------------- sub1, left -------------------------
app_unit_obj_left = approximate_unit_class;
truthTable_obj_input = app_unit_obj.truthTable_left_obj_output;
row_var_id_vec_input = [2];
col_var_id_vec_input = [1,3];
app_unit_obj_left = set_approximate_unit(app_unit_obj_left, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%-------------- sub1, right -------------------------
app_unit_obj_right = approximate_unit_class;
truthTable_obj_input = app_unit_obj.truthTable_right_obj_output;
row_var_id_vec_input = [4,5];
col_var_id_vec_input = [6];
app_unit_obj_right = set_approximate_unit(app_unit_obj_right, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%========================================================
% trace back

% traceBackUnit_obj1 = traceBack_unit_class;
% traceBackUnit_obj2 = traceBack_unit_class;
% traceBackUnit_obj3 = traceBack_unit_class;
% 
% traceBackUnit_obj1 = set_traceBack_unit(traceBackUnit_obj1,app_unit_obj_left,app_unit_obj_right,app_unit_obj);
% 

traceBackUnit_obj = traceBack_unit_class;
traceBackUnit_obj = set_traceBack_unit(traceBackUnit_obj,app_unit_obj_left,app_unit_obj_right,app_unit_obj);
%traceBackUnit_obj.app_kmap_obj_upper_level.kmap
approximated_kmap = traceBackUnit_obj.app_kmap_obj_upper_level_modified.kmap
original_kmap = traceBackUnit_obj.app_unit_obj.kmap_obj.kmap
error_count = sum(sum(original_kmap~=approximated_kmap))
error_count_rate = error_count/(size(original_kmap,1)*size(original_kmap,2))




