clear all;
clc;

kmap_obj = kmap_class;
kmap_obj.row_var_id_vec = [3,4];
kmap_obj.column_var_id_vec = [1,2,5];
kmap_obj.kmap = [0 0 0 0 0 0 0 0;
                 1 0 0 1 1 0 1 1;
                 1 1 0 0 0 0 1 0;
                 1 0 1 1 1 1 0 0];
truthTable_obj = truthTable_class;
truthTable_obj = set_truthTable_by_oneRow_of_kmap(truthTable_obj, kmap_obj);

f_vec = truthTable_obj.f_vec
f_vec_obtained = f_vec_verification(truthTable_obj)
disp('------------------');



row_var_id_vec__new = [2 5];
column_var_id_vec__new = [1];

truthTable_obj

kmap_obj2 = kmap_class;
kmap_obj2 = set_kmap_by_truthTable(kmap_obj2, truthTable_obj, column_var_id_vec__new, row_var_id_vec__new);
kmap_obj2.kmap












