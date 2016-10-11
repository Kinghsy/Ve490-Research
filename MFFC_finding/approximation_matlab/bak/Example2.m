clear;
clc;

% given the truth table
truthTable_obj = truthTable_class;
var_id_vec = [1,2,3,4];
f_vec = [1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 1];
%f_vec = [1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 1];
f_vec_original = f_vec;
truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);

% convert this truth table to the kmap
kmap_obj = kmap_class;
row_var_id_vec = [1,2];
column_var_id_vec = [3,4];
kmap_obj = set_kmap_by_truthTable(kmap_obj, truthTable_obj, column_var_id_vec, row_var_id_vec);
kmap_original = kmap_obj.kmap

% get the approximated kmap
[kmap_approximate_obj,approximate_error_count] = approximation_core(kmap_obj);

kmap_approximate_obj.kmap
approximate_error_count


%%
% % get subfunctions' truth tables
% truthTable1 = truthTable_class;
% [truthTable1,kmap_approximate_obj] = set_truthTable_by_oneCol_of_kmap(truthTable1, kmap_approximate_obj);
% truthTable2 = truthTable_class;
% [truthTable2,kmap_approximate_obj] = set_truthTable_by_oneRow_of_kmap(truthTable2, kmap_approximate_obj);
% 
% % convert back to the truth table
% truthTable_approximate_obj = truthTable_class;
% var_id_vec = [1,2,3,4];
% truthTable_approximate_obj = init_truthTable(truthTable_approximate_obj, var_id_vec, []);
% truthTable_approximate_obj = set_truthTable_by_kmap(truthTable_approximate_obj, kmap_approximate_obj);
% 
% f_vec_original = f_vec_original
% f_vec_approximate = truthTable_approximate_obj.f_vec
% 
% f_vec_error_count = sum(f_vec_original~=f_vec_approximate)
% f_vec_error_rate = f_vec_error_count/length(f_vec_original)
% %           
% % % given truthTable_obj, get corresponding kmap_obj
% % truthTable_obj = truthTable_class;
% % var_id_vec = [2,4,1,3];
% % truthTable_obj = init_truthTable(truthTable_obj, var_id_vec);
% % truthTable_obj = set_truthTable_by_kmap(truthTable_obj, kmap_obj);
% % 
% % 
% % 
% % 
% % % given kmap_obj, get corresponding truthTable_obj
% % row_var_id_vec = [1,4];
% % column_var_id_vec = [2,3];
% % kmap_obj2 = kmap_class;
% % kmap_obj2 = set_kmap_by_truthTable(kmap_obj2, truthTable_obj, column_var_id_vec, row_var_id_vec)
% % kmap_obj2.kmap
% 
% 
% 
