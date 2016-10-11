classdef solution_choice_class
    properties
        maj_vec;
        maj_complement_vec;
        cost_vec_matrix; % 4 terms: cost of changing to all 0s, all 1s, maj_vec, maj_vec_complement
        kmap_original;
        kmap_modified;
        final_cost;
    end

    methods
        function obj = set_maj_complement_vec(obj)
            obj.maj_complement_vec = (obj.maj_vec == 0);
        end
        function obj = init_solution_choice(obj, maj_vec, kmap_original)
            obj.maj_vec = maj_vec;
            obj = set_maj_complement_vec(obj);
            obj.kmap_original = kmap_original;
            kmap_row_number = size(kmap_original,1);
            obj.cost_vec_matrix = zeros(kmap_row_number,4);
        end
        
        
        
        %% all 0's and majority
        
        function obj = set_cost_vec_matrix1(obj)
            kmap_row_number = size(obj.kmap_original,1);
            for i=1:1:kmap_row_number
                row_vec = obj.kmap_original(i,:);
                maj_vec1 = obj.maj_vec;
                maj_complement_vec1 = obj.maj_complement_vec;
                obj.cost_vec_matrix(i,1) = sum(row_vec~=0); % cost of changing to all 0s
                obj.cost_vec_matrix(i,2) = sum(xor(row_vec,maj_vec1)); % cost of changing to maj_vec
            end
        end
        
        function obj = set_best_approximate_kmap1(obj)
            % for one row, if min cost are changing to all 1s and 0s,
            % then choose all 0s
            % if min cost, one is to all 1s or 0s, the other is to
            % maj_vec or maj_complement_vec, choose to all 1s or 0s
            % in summary, choose the first min if 2 or more mins occurs
            obj.kmap_modified = obj.kmap_original;
            kmap_row_number = size(obj.kmap_original,1);
            truthTable_col_number = size(obj.kmap_original,2);
            for i=1:1:kmap_row_number
                cost_vec = obj.cost_vec_matrix(i,:);
                
                if(cost_vec(1) < cost_vec(2)) % change the row to maj_vec
                    obj.kmap_modified(i,:) = zeros(1,truthTable_col_number);
                else % change the row to maj_complement_vec
                    obj.kmap_modified(i,:) = obj.maj_vec;
                end
            end
            obj.final_cost = sum(sum(xor(obj.kmap_modified, obj.kmap_original)));
        end
         %% all 1s and maj
        
        function obj = set_cost_vec_matrix2(obj)
            kmap_row_number = size(obj.kmap_original,1);
            for i=1:1:kmap_row_number
                row_vec = obj.kmap_original(i,:);
                maj_vec1 = obj.maj_vec;
                maj_complement_vec1 = obj.maj_complement_vec;
                obj.cost_vec_matrix(i,1) = sum(row_vec~=1); % cost of changing to all 1s
                obj.cost_vec_matrix(i,2) = sum(xor(row_vec,maj_vec1)); % cost of changing to maj_vec
            end
        end
        
        function obj = set_best_approximate_kmap2(obj)
            % for one row, if min cost are changing to all 1s and 0s,
            % then choose all 0s
            % if min cost, one is to all 1s or 0s, the other is to
            % maj_vec or maj_complement_vec, choose to all 1s or 0s
            % in summary, choose the first min if 2 or more mins occurs
            obj.kmap_modified = obj.kmap_original;
            kmap_row_number = size(obj.kmap_original,1);
            truthTable_col_number = size(obj.kmap_original,2);
            for i=1:1:kmap_row_number
                cost_vec = obj.cost_vec_matrix(i,:);
                
                if(cost_vec(1) < cost_vec(2)) % change the row to maj_vec
                    obj.kmap_modified(i,:) = ones(1,truthTable_col_number);
                else % change the row to maj_complement_vec
                    obj.kmap_modified(i,:) = obj.maj_vec;
                end
            end
            obj.final_cost = sum(sum(xor(obj.kmap_modified, obj.kmap_original)));
        end
        
        %%
        function obj = set_cost_vec_matrix3(obj)
            kmap_row_number = size(obj.kmap_original,1);
            for i=1:1:kmap_row_number
                row_vec = obj.kmap_original(i,:);
                maj_vec1 = obj.maj_vec;
                maj_complement_vec1 = obj.maj_complement_vec;
                obj.cost_vec_matrix(i,1) = sum(xor(row_vec,maj_vec1)); % cost of changing to maj_vec
                obj.cost_vec_matrix(i,2) = sum(xor(row_vec,maj_complement_vec1)); % cost of changing to maj_complement_vec
            end
        end

        function obj = set_best_approximate_kmap3(obj)
            % for one row, if min cost are changing to all 1s and 0s,
            % then choose all 0s
            % if min cost, one is to all 1s or 0s, the other is to
            % maj_vec or maj_complement_vec, choose to all 1s or 0s
            % in summary, choose the first min if 2 or more mins occurs
            obj.kmap_modified = obj.kmap_original;
            kmap_row_number = size(obj.kmap_original,1);
            truthTable_col_number = size(obj.kmap_original,2);
            for i=1:1:kmap_row_number
                cost_vec = obj.cost_vec_matrix(i,:);
                
                if(cost_vec(1) < cost_vec(2)) % change the row to maj_vec
                    obj.kmap_modified(i,:) = obj.maj_vec;
                else % change the row to maj_complement_vec
                    obj.kmap_modified(i,:) = obj.maj_complement_vec;
                end
            end
            obj.final_cost = sum(sum(xor(obj.kmap_modified, obj.kmap_original)));
        end
    end
end









