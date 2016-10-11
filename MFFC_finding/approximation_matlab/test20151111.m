clear;
clc;

% given the truth table
truthTable_obj = truthTable_class;
var_id_vec = [1,2,3];
%f_vec = [1 0 1 0 0 1 1 0];
f_vec = [0 1 2 3 4 5 6 7];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);

kmap_var_id_vec = [1 3 2];
kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_var_id_vec)








