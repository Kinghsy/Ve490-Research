function [approximate_kmap_obj,approximate_error_count] = find_best_approximate_kmap4(kmap_obj, enable_fast_mode, dont_care_upper_bound)

% only use all 0s and 1s rows to approximate

kmap = kmap_obj.kmap;
kmap_row_count = size(kmap,1);
kmap_column_count = size(kmap,2);
maj_vec_original = zeros(1,kmap_column_count);

bestApproximate_kmap = [];

for i=1:1:kmap_row_count
    kmap_row_vec = kmap(i,:);
    if(sum(kmap_row_vec == 1) > sum(kmap_row_vec == 0))
        bestApproximate_kmap = [bestApproximate_kmap;ones(1,kmap_column_count)];
    else
        bestApproximate_kmap = [bestApproximate_kmap;zeros(1,kmap_column_count)];
    end
end


approximate_error_count = sum(sum(xor(kmap,bestApproximate_kmap)));

approximate_kmap_obj = kmap_obj;
approximate_kmap_obj.kmap = bestApproximate_kmap;

approximate_kmap_obj.approximation_cost = approximate_error_count;




