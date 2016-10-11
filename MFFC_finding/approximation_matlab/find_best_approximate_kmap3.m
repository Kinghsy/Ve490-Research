function [approximate_kmap_obj,approximate_error_count] = find_best_approximate_kmap3(kmap_obj, enable_fast_mode, dont_care_upper_bound)

kmap = kmap_obj.kmap;
kmap_column_count = size(kmap,2);
maj_vec_original = zeros(1,kmap_column_count);

for i=1:1:kmap_column_count
    count_of_1s = sum(kmap(:,i));
    count_of_0s = sum(kmap(:,i)==0);
    if(count_of_1s > count_of_0s)
        maj_bit = 1;
    elseif(count_of_1s < count_of_0s)
        maj_bit = 0;
    else
        maj_bit = -1;
    end
    maj_vec_original(i) = maj_bit;
end

dont_care_count = sum(maj_vec_original==-1);
dont_care_id_vec = find(maj_vec_original==-1);
%------------fast mode-------------------
if(enable_fast_mode == 1)
    if(dont_care_count > dont_care_upper_bound)
        dont_care_count = dont_care_upper_bound;
        %dont_care_id_vec = dont_care_id_vec(1:dont_care_count);
    end
end
%-------------------------------


bin_vec_record = [];
for dec_value=1:1:2^dont_care_count
    vec1 = dec2bin(dec_value-1)-'0';
	bin_vec = [zeros(1,length(dont_care_id_vec)-length(vec1)),vec1];
    bin_vec_record = [bin_vec_record; bin_vec];
end

maj_vec_matrix = [];
for i=1:1:2^dont_care_count
    vec = maj_vec_original;
    for j=1:1:length(dont_care_id_vec)
        dont_care_id = dont_care_id_vec(j);
        vec(dont_care_id) = bin_vec_record(i,j);
    end
    maj_vec_matrix = [maj_vec_matrix;vec];
end

% restrict the search
% if(dont_care_count > 5)
%     dont_care_count = 5;
% end
solution_choice_total_number = 2^dont_care_count;

solution_choice_record = [];
for i=1:1:solution_choice_total_number
    sol_choice_obj = solution_choice_class;
    maj_vec = maj_vec_matrix(i,:);
    kmap_original = kmap;
    sol_choice_obj = init_solution_choice(sol_choice_obj, maj_vec, kmap_original);
    sol_choice_obj = set_cost_vec_matrix3(sol_choice_obj);
    sol_choice_obj = set_best_approximate_kmap3(sol_choice_obj);
    solution_choice_record = [solution_choice_record, sol_choice_obj];
    cost_vec_matrix = sol_choice_obj.cost_vec_matrix;
    maj_vec_disp = sol_choice_obj.maj_vec;
    maj_complement_vec_disp = sol_choice_obj.maj_complement_vec;

end

% find sol_choice_obj with minimum final_cost
final_cost_min = Inf;
for i=1:1:length(solution_choice_record)
    sol_obj = solution_choice_record(i);
    if(sol_obj.final_cost < final_cost_min)
        final_cost_min = sol_obj.final_cost;
        sol_choice_optimal = sol_obj;
    end
end

kmap_approximate = kmap;
for i=1:1:size(kmap,1)
    kmap_approximate(i,:) = sol_choice_optimal.kmap_modified(i,:);
end

bestApproximate_kmap = kmap_approximate;
approximate_kmap_obj = kmap_obj;
approximate_kmap_obj.kmap = bestApproximate_kmap;

approximate_error_count = sum(sum(xor(kmap,kmap_approximate)));

approximate_kmap_obj.approximation_cost = approximate_error_count;
approximate_kmap_obj.majority_row_vec = sol_choice_optimal.maj_vec;
approximate_kmap_obj.majority_complement_row_vec = sol_choice_optimal.maj_complement_vec;





