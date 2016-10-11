function kmap_new_vec = set_kmap_vec_by_truthTable(truthTable_obj, kmap_var_id_vec)
truthTable_var_id_vec = truthTable_obj.var_id_vec;
truthTable_obj = init_truthTable(truthTable_obj, truthTable_obj.var_id_vec, truthTable_obj.f_vec);
if(is_two_vec_equal(kmap_var_id_vec,truthTable_var_id_vec) == 1)
    kmap_new_vec = truthTable_obj.f_vec;
else
    kmap_cell_obj_vec = [];
    for i=1:1:2^length(kmap_var_id_vec)
        kmap_cell_obj = kmap_cell_class;
        values = dec2bin(i-1)-'0';
        bin_vec1 = [zeros(1,length(kmap_var_id_vec)-length(values)),values];
        kmap_cell_obj.var_value_vec = bin_vec1;
        kmap_cell_obj.var_id_vec = kmap_var_id_vec;
        kmap_cell_obj_vec = [kmap_cell_obj_vec, kmap_cell_obj];
    end
    
    truthTable_var_id_left2right = truthTable_obj.var_id_vec;
    kmap_cell_var_id_vec = kmap_var_id_vec;
    index_vec = [];
    for k=1:1:length(truthTable_var_id_left2right)
        var_id_reference = truthTable_var_id_left2right(k);
        index = find(kmap_cell_var_id_vec==var_id_reference);
        index_vec = [index_vec, index];
    end
    kmap_new_vec = [];
    for i=1:1:2^length(kmap_var_id_vec)
        x_vec = [];
        for k=1:1:length(index_vec)
            index = index_vec(k);
            x_bit = kmap_cell_obj_vec(i).var_value_vec(index);
            x_vec = [x_vec,x_bit];
        end
        %truthTable_obj.f_vec
        %truthTable_obj.var_id_vec
        output_bit = get_truthTable_output_bit(truthTable_obj, x_vec);
        kmap_cell_obj_vec(i).content_value = output_bit;
        kmap_new_vec = [kmap_new_vec,output_bit];
    end
end
