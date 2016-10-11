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
row_var_id_vec_input = [1,2,3];
col_var_id_vec_input = [4,5,6];
app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

app_unit_obj

%-------------- sub, left -------------------------
app_unit_obj_left = approximate_unit_class;
truthTable_obj_input = app_unit_obj.truthTable_left_obj_output;
row_var_id_vec_input = [4];
col_var_id_vec_input = [5,6];
app_unit_obj_left = set_approximate_unit(app_unit_obj_left, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%-------------- sub, right -------------------------
app_unit_obj_right = approximate_unit_class;
truthTable_obj_input = app_unit_obj.truthTable_right_obj_output;
row_var_id_vec_input = [1];
col_var_id_vec_input = [2,3];
app_unit_obj_right = set_approximate_unit(app_unit_obj_right, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%========================================================



traceBackUnit_obj = traceBack_unit_class;

app_unit_obj_left.kmap_approximated_obj.kmap = [1 0 1 0;1 0 1 0]; % modify row vec
app_unit_obj_right.kmap_approximated_obj.kmap = [0 0 0 1;1 1 0 1];

app_kmap_left_obj_input = app_unit_obj_left.kmap_approximated_obj;
app_kmap_right_obj_input = app_unit_obj_right.kmap_approximated_obj;


%[traceBackUnit_obj,app_unit_obj] = set_traceBack_unit(traceBackUnit_obj,app_unit_obj_left,app_unit_obj_right,app_unit_obj);



app_kmap_obj_upper_level = app_unit_obj.kmap_approximated_obj;

traceBackUnit_obj = set_traceBack_unit(traceBackUnit_obj,app_unit_obj_left,app_unit_obj_right,app_unit_obj);

traceBackUnit_obj.app_kmap_obj_upper_level.kmap
traceBackUnit_obj.app_kmap_obj_upper_level_modified.kmap

