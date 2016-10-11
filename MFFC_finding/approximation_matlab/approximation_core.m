function [kmap_approximate_obj,approximate_error_count] = approximation_core(kmap_obj, enable_fast_mode, dont_care_upper_bound) % separate f(x1,x2,...,xn) to f(g1,g2)

%enable_fast_mode = 1;
%dont_care_upper_bound = 5;

[kmap_approximate_obj1,approximate_error_count1] = find_best_approximate_kmap1(kmap_obj, enable_fast_mode, dont_care_upper_bound); % approximate by all-0s and maj rows
[kmap_approximate_obj2,approximate_error_count2] = find_best_approximate_kmap2(kmap_obj, enable_fast_mode, dont_care_upper_bound); % approximate by all-1s and maj rows
[kmap_approximate_obj3,approximate_error_count3] = find_best_approximate_kmap3(kmap_obj, enable_fast_mode, dont_care_upper_bound); % approximate by maj and maj-complement rows, or only use maj rows (resulting in all rows the same pattern)
[kmap_approximate_obj4,approximate_error_count4] = find_best_approximate_kmap4(kmap_obj, enable_fast_mode, dont_care_upper_bound); % approximate by all-0s and all-1s rows

% choose the min cost one among the them. If equility occurs, then
% priority: 4>1>2>3
%approximate_error_count_vec
approximate_error_count_vec = [approximate_error_count4,approximate_error_count1,approximate_error_count2,approximate_error_count3];
kmap_approximate_obj_vec = [kmap_approximate_obj4,kmap_approximate_obj1,kmap_approximate_obj2,kmap_approximate_obj3];
min_index_vec = find(approximate_error_count_vec == min(approximate_error_count_vec));
index_chosen = min_index_vec(1);
kmap_approximate_obj = kmap_approximate_obj_vec(index_chosen);

%kmap_majority_row_vec = kmap_approximate_obj.majority_row_vec
%kmap_majority_col_vec = kmap_approximate_obj.majority_col_vec

approximate_error_count = approximate_error_count_vec(index_chosen);