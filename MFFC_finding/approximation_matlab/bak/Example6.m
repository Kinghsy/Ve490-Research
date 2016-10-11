clear;
clc;

% col var: go to left
% row var: go to right

% given the truth table
truthTable_obj = truthTable_class;
var_id_vec = [1,2,3,4,5,6];
f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);


app_unit_obj = approximate_unit_class;
truthTable_obj_input = truthTable_obj;
row_var_id_vec_input = [5,6]; % row var go to right
col_var_id_vec_input = [1,2,3,4]; % col var go to left
app_unit_obj = set_isLeaf(app_unit_obj, truthTable_obj_input);
app_unit_obj = set_approximate_unit(app_unit_obj, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);


%-------------- sub1, left -------------------------
app_unit_obj_sub1_left = approximate_unit_class;
truthTable_obj_input = app_unit_obj.truthTable_left_obj_output;
row_var_id_vec_input = [4];
col_var_id_vec_input = [1,2,3];
app_unit_obj_sub1_left = set_isLeaf(app_unit_obj_sub1_left, truthTable_obj_input);
app_unit_obj_sub1_left = set_approximate_unit(app_unit_obj_sub1_left, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%-------------- sub1, right -------------------------
app_unit_obj_sub1_right = approximate_unit_class;
truthTable_obj_input = app_unit_obj.truthTable_right_obj_output;
row_var_id_vec_input = [5];
col_var_id_vec_input = [6];
app_unit_obj_sub1_right = set_isLeaf(app_unit_obj_sub1_right, truthTable_obj_input);
app_unit_obj_sub1_right = set_approximate_unit(app_unit_obj_sub1_right, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);


%-------------- sub2, left -------------------------
app_unit_obj_sub2_left = approximate_unit_class;
truthTable_obj_input = app_unit_obj_sub1_left.truthTable_left_obj_output;
row_var_id_vec_input = [3];
col_var_id_vec_input = [1,2];
app_unit_obj_sub2_left = set_isLeaf(app_unit_obj_sub2_left, truthTable_obj_input);
app_unit_obj_sub2_left = set_approximate_unit(app_unit_obj_sub2_left, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%-------------- sub2, right -------------------------
app_unit_obj_sub2_right = approximate_unit_class;
truthTable_obj_input = app_unit_obj_sub1_left.truthTable_right_obj_output;
row_var_id_vec_input = [4];
col_var_id_vec_input = [];
app_unit_obj_sub2_right = set_isLeaf(app_unit_obj_sub2_right, truthTable_obj_input);
app_unit_obj_sub2_right = set_approximate_unit(app_unit_obj_sub2_right, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);


%-------------- sub3, left -------------------------
app_unit_obj_sub3_left = approximate_unit_class;
truthTable_obj_input = app_unit_obj_sub2_left.truthTable_left_obj_output;
row_var_id_vec_input = [1,2];
col_var_id_vec_input = [];
app_unit_obj_sub3_left = set_isLeaf(app_unit_obj_sub3_left, truthTable_obj_input);
app_unit_obj_sub3_left = set_approximate_unit(app_unit_obj_sub3_left, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%-------------- sub3, right -------------------------
app_unit_obj_sub3_right = approximate_unit_class;
truthTable_obj_input = app_unit_obj_sub2_left.truthTable_right_obj_output;
truthTable_obj_input
row_var_id_vec_input = [3];
col_var_id_vec_input = [];
app_unit_obj_sub3_right = set_isLeaf(app_unit_obj_sub3_right, truthTable_obj_input);
app_unit_obj_sub3_right = set_approximate_unit(app_unit_obj_sub3_right, truthTable_obj_input, row_var_id_vec_input, col_var_id_vec_input);

%========================================================
% trace back

traceBackUnit_obj1 = traceBack_unit_class;
traceBackUnit_obj2 = traceBack_unit_class;

traceBackUnit_obj1 = set_traceBack_unit(traceBackUnit_obj1,app_unit_obj_sub2_left,app_unit_obj_sub2_right,app_unit_obj_sub1_left);
traceBackUnit_obj2 = set_traceBack_unit(traceBackUnit_obj2,app_unit_obj_sub1_left,app_unit_obj_sub1_right,app_unit_obj);
%traceBackUnit_obj.app_kmap_obj_upper_level.kmap




approximated_kmap = traceBackUnit_obj2.app_kmap_obj_upper_level_modified.kmap
original_kmap = app_unit_obj.kmap_obj.kmap
error_count = sum(sum(original_kmap~=approximated_kmap))
error_count_rate = error_count/(size(original_kmap,1)*size(original_kmap,2))




