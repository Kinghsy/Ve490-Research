% f(x1,x2,x3,x4)->f(g(x1,x2,x3),x4)->f(g(h(x1,x2),x3),x4)
clear all;
clc;

sol_obj = solution_class;
level_obj1 = level_vec_chosen_class;
level_obj2 = level_vec_chosen_class;
level_obj3 = level_vec_chosen_class;

level_obj1.vec_chosen_this_level = [4]; % row var id
level_obj2.vec_chosen_this_level = [3]; % row var id
%level_obj3.vec_chosen_this_level = [4];

sol_obj.level_vec_chosen_obj_vec = [level_obj1 level_obj2];
 

% original truth table
truthTable_obj = truthTable_class;
var_id_vec = [1 2 3 4]; % sort in order
f_vec = [1 0 1 0 1 1 0 1 1 0 0 1 1 1 0 0];
truthTable_obj = set_truthTable_n_inputs(truthTable_obj, f_vec, var_id_vec);

% level 1
kmap_obj = kmap_class;
row_var_id_vec = [4];
column_var_id_vec = [1,2,3];
kmap_obj = set_kmap_by_truthTable(kmap_obj, truthTable_obj, column_var_id_vec, row_var_id_vec);

kmap = kmap_obj.kmap

[bestApproximateKmap,approximate_error]  = find_best_approximate_kmap(kmap)

kmap_original_obj = kmap_obj;
kmap_approximate_obj = kmap_obj;
kmap_approximate_obj.kmap = bestApproximateKmap;
level_obj1.kmap_original_obj = kmap_original_obj;
level_obj1.kmap_approximate_obj = kmap_approximate_obj;

disp('=====================');
% level 2
kmap_obj2 = kmap_obj;
kmap_obj2.kmap = bestApproximateKmap;
truthTable_obj2 = truthTable_class;
truthTable_obj2 = set_truthTable_by_oneRow_of_kmap(truthTable_obj2, kmap_obj2);

%------------------
kmap_obj2 = kmap_class;
row_var_id_vec = [3];
column_var_id_vec = [1,2];
kmap_obj2 = set_kmap_by_truthTable(kmap_obj2, truthTable_obj2, column_var_id_vec, row_var_id_vec);

kmap = kmap_obj2.kmap

[bestApproximateKmap,approximate_error]  = find_best_approximate_kmap(kmap)

kmap_original_obj2 = kmap_obj2;
kmap_approximate_obj2 = kmap_obj2;
kmap_approximate_obj2.kmap = bestApproximateKmap;
level_obj2.kmap_original_obj = kmap_original_obj2;
level_obj2.kmap_approximate_obj = kmap_approximate_obj2;



%================================================
% trace back to find the overall approximate truth table

truthTable_obj2_back = truthTable_obj2;
truthTable_obj2_back = set_truthTable_by_kmap(truthTable_obj2_back, kmap_approximate_obj); % need more debug








