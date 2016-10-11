clear;
clc;

kmap_obj = kmap_class;
kmap_obj.row_var_id_vec = [1,4];
kmap_obj.column_var_id_vec = [2,3];

% kmap_obj.kmap = [0 1 1 1;
%               1 0 0 0;
%               1 1 1 0;
%               0 0 1 1];

kmap_obj.kmap = [1 2 3 4;
              5 6 7 8;
              9 10 11 12;
              13 14 15 16];

          
% given truthTable_obj, get corresponding kmap_obj
truthTable_obj = truthTable_class;
var_id_vec = [2,4,1,3];
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec);
truthTable_obj = set_truthTable_by_kmap(truthTable_obj, kmap_obj);




% given kmap_obj, get corresponding truthTable_obj
row_var_id_vec = [1,4];
column_var_id_vec = [2,3];
kmap_obj2 = kmap_class;
kmap_obj2 = set_kmap_by_truthTable(kmap_obj2, truthTable_obj, column_var_id_vec, row_var_id_vec)
kmap_obj2.kmap



