function obj = init_truthTable(obj, var_id_vec, f_vec)
            obj.f_vec = f_vec;
            obj.var_id_vec = var_id_vec;
            truthTable_var_number = length(var_id_vec);
            obj.input_var_number = truthTable_var_number;
            truthTable_row_number = 2^truthTable_var_number;
            x_matrix = [];
            for i=1:1:truthTable_row_number
                values = dec2bin(i-1)-'0';
                bin_vec = [zeros(1,truthTable_var_number-length(values)),values];
                x_matrix = [x_matrix;bin_vec];
            end
            obj.x_matrix = x_matrix;
        end