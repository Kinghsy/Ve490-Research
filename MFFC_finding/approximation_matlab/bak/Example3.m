clear;
clc;

% given the truth table
truthTable_obj = truthTable_class;
var_id_vec = [1,2,3,4];
f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);


app_unit_obj = approximate_unit_class;
truthTable_obj_input = truthTable_obj;
row_var_id_vec_input = [1,2];
col_var_id_vec_input = [3,4];

app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

app_unit_obj



% traceBackUnit_obj = traceBack_unit_class;
% app_kmap_left_obj_input = 
% app_kmap_right_obj_input = 
% app_kmap_obj_upper_level = app_unit_obj.kmap_approximated_obj;
% traceBackUnit_obj = set_traceBack_unit(traceBackUnit_obj,app_kmap_left_obj_input,app_kmap_right_obj_input,app_kmap_obj_upper_level);
% 






