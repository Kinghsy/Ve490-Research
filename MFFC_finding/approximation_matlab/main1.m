
%need_solution_space_generation = 1;

%if(need_solution_space_generation == 1)
clear all;
clc;

%t1 = cputime;

% seed = 0; % seed=1, good test, 295 solutions, after approximate, all 0's or all 1's kmap occurs
% rand('seed',seed);

%test_number = 10;

f_vec = importdata('inputs/f_vec.txt');
f_vec_length = length(f_vec);
var_number = log2(f_vec_length);
%var_id_vec = [1,2,3,4,5];
var_id_vec = 1:1:var_number
    
enable_fast_mode = 1;
dont_care_upper_bound = 1;


test_id_debug = 8;




%f_vec_record = [];
min_error_rate_record = [];
binaryTree_node_root_minError_record = [];
cpu_time_record = [];

% for ii=1:1:test_number
%     f_vec = (rand(1,2^length(var_id_vec)) > 0.5);
%     f_vec_record = [f_vec_record;f_vec];
% end

tic;
global_LUTs_count_record = [];
global_errorRate_chosen_record = [];
%for ii=1:1:test_number
%for ii=test_id_debug:1:test_id_debug
for ii=1:1:1
    t1 = cputime;
    disp('test id:');
    ii
    binaryTree_node_root = binaryTree_node_class;
    is_root = 1;
    binaryTree_node_root = init_binaryTree_node(binaryTree_node_root,var_id_vec,is_root);
    binaryTree_node_root = build_binaryTree_helper(binaryTree_node_root);
    %end

    % given the truth table
    truthTable_obj = truthTable_class;
    %rng('default');

    %f_vec = f_vec_record(ii,:);
    %f_vec = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    f_vec
    f_vec_original = f_vec;
    truthTable_obj = init_truthTable(truthTable_obj, var_id_vec, f_vec);

    %========================================================================
    % binaryTree part

    is_root = 1;
    tree_node_root = tree_node_class;
    tree_node_root = init_tree_node(tree_node_root,var_id_vec,is_root);
    tree_node_root = build_tree_helper(tree_node_root);
    disp('tree_node_root building finished! Start to traverse tree...');

    %tic;
    tree_node_root.truth_table_obj = truthTable_obj;
    tree_node_root = traverse_tree_branch_and_bound(tree_node_root, enable_fast_mode, dont_care_upper_bound);
    %tree_node_root = traverse_tree(tree_node_root, global_error_min_bound);
    %disp('Traversing tree finished!');
    %traversing_time = toc

    %disp('Traversing tree finished! Start to trace back the tree...');

    % traceBack_tree needs more thinking!!!
    %tree_node_root = traceBack_tree(tree_node_root);

    
    disp('Traversing tree finished! Start binary tree extraction...');

    tree_node_root_test = tree_node_root;
    binaryTree_node_root = binaryTree_node_class;
    [tree_node_root_test, binaryTree_node_root] = extract_optimal_binaryTrees_BranchAndBound(tree_node_root_test, binaryTree_node_root);

%     binaryTree_node_root_record = [];
%     while(tree_node_root_test.is_visited == 0)
%         binaryTree_node_root = binaryTree_node_class;
%         [tree_node_root_test, binaryTree_node_root] = extract_binaryTrees(tree_node_root_test, binaryTree_node_root);
%         binaryTree_node_root_record = [binaryTree_node_root_record,binaryTree_node_root];
%     end
% 
disp('Binary tree extraction finishes! Starts trace back...');

fid=fopen('results/apprx_circuit.blif','w');


circuit_output_wire_basic_name = 'f'; % basic name for the output wire, in the file apprx_circuit.blif

circuit_input_wire_names_ordered = [];
for j=1:1:var_number
	input_name = input_names_class;
	input_name.name = ['x',num2str(j)];
	circuit_input_wire_names_ordered = [circuit_input_wire_names_ordered,input_name];
end


[error_rate, binaryTree_node_root, is_fully_decomposed, fid] = approximate_one_binaryTree__main(binaryTree_node_root,truthTable_obj, fid, circuit_output_wire_basic_name, circuit_input_wire_names_ordered);
fclose(fid);
error_rate

binaryTree_node_root_minError_record = [binaryTree_node_root_minError_record, binaryTree_node_root];
min_error_rate_record = [min_error_rate_record, error_rate];
%         

%     error_rate_record = [];
%     error_rate_min = Inf;
%     valid_binaryTree_node_root_record = [];
%     for i=1:1:length(binaryTree_node_root_record)
%         %i
%         binaryTree_node_root = binaryTree_node_root_record(i);    
%         [error_rate, binaryTree_node_root, is_fully_decomposed] = approximate_one_binaryTree__main(binaryTree_node_root,truthTable_obj);
%         
%         if(error_rate < error_rate_min)
%             error_rate_min = error_rate;
%             error_rate_min_index = i;
%         end
%         if(is_fully_decomposed == 1)
%             valid_binaryTree_node_root_record = [valid_binaryTree_node_root_record, binaryTree_node_root];
%         end
%         binaryTree_node_root_record(i) = binaryTree_node_root;
%         error_rate_record = [error_rate_record, error_rate];
%     end
%     min_error_rate = min(error_rate_record)
%     min_error_rate_record = [min_error_rate_record,min_error_rate];
%     binaryTree_node_root_minError = binaryTree_node_root_record(error_rate_min_index);
%     binaryTree_node_root_minError_record = [binaryTree_node_root_minError_record,binaryTree_node_root_minError];
% 
%     disp('Tracing back finishes!');
% 
% 
% 
%     % ----------------------------------------------------------------------
%     % counting the leaf node and non-leaf node for each binary tree
%     %two_input_LUTs_count_vec = zeros(1,length(binaryTree_node_root_record));
%     %LUTs_number_vs_error_product_vec = zeros(1,length(binaryTree_node_root_record));
% %     for i=1:1:length(binaryTree_node_root_record)
% %         leaf_node_count = 0;
% %         nonleaf_node_count = 0;
% %         binaryTreeNode_obj = binaryTree_node_root_record(i);
% %         [leaf_node_count, nonleaf_node_count] = counting_binary_tree_nodes(binaryTreeNode_obj, leaf_node_count, nonleaf_node_count);
% %         binaryTree_node_root_record(i).leaf_node_count = leaf_node_count;
% %         binaryTree_node_root_record(i).nonleaf_node_count = nonleaf_node_count;
% %         LUTs_number = nonleaf_node_count;
% %         two_input_LUTs_count_vec(i) = LUTs_number;
% %         LUTs_number_vs_error_product_vec(i) = LUTs_number * error_rate_record(i);
% %     end
%     % ----------------------------------------------------------------------
%     LUTs_number_vs_error_product_vec_min_index = find(LUTs_number_vs_error_product_vec == min(LUTs_number_vs_error_product_vec))
%     LUTs_count_record = [];
%     error_rate_minAreaErrorProduct_record = [];
%     for j=1:1:length(LUTs_number_vs_error_product_vec_min_index)
%         index = LUTs_number_vs_error_product_vec_min_index(j);
%         LUTs_count = binaryTree_node_root_record(index).nonleaf_node_count;
%         error_rate = error_rate_record(index);
%         LUTs_count_record = [LUTs_count_record, LUTs_count];
%         error_rate_minAreaErrorProduct_record = [error_rate_minAreaErrorProduct_record, error_rate];
%     end
%     LUTs_count_record
%     error_rate_minAreaErrorProduct_record
%     
%     global_LUTs_count_record = [global_LUTs_count_record, mean(LUTs_count_record)];
%     global_errorRate_chosen_record = [global_errorRate_chosen_record, mean(error_rate_minAreaErrorProduct_record)];
%     
%     two_input_LUTs_count_min = min(two_input_LUTs_count_vec)
%     two_input_LUTs_count_max = max(two_input_LUTs_count_vec)
%     
%     min_error_rate = min(error_rate_record)
%     max_error_rate = max(error_rate_record)
%     
%     
    total_time = cputime - t1
    cpu_time_record = [cpu_time_record, total_time];
     disp('=======================');
     
end
% 
% 
% 
% total_runtime = toc;
% runtime_average = total_runtime / test_number
% 
% error_rate_average = mean(min_error_rate_record)
% error_rate_stdVar = sqrt(var(min_error_rate_record))
% 
% %LUTs_number_mean = mean(global_LUTs_count_record)
% %errorRate_chosen_mean = mean(global_errorRate_chosen_record);
% 
% min_error_rate_index = find(error_rate_record == min(error_rate_record))
% max_error_rate_index = find(error_rate_record == max(error_rate_record))
% 
% 
% 
% 

% get error bit count
%sum(binaryTree_node_root_minError_record(1).truth_table_obj.f_vec ~= binaryTree_node_root_minError_record(1).truth_table_approximated_obj.f_vec)

% fid=fopen('.\results\f_vec_record.txt','w');
% for i=1:1:size(f_vec_record,1)
%     for j=1:1:size(f_vec_record,2)
%         fprintf(fid,'%d ',f_vec_record(i,j));
%     end
%     fprintf(fid,'\n');
% end
% fclose(fid);

exit;




