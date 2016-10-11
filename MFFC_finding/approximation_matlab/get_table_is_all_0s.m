function is_all_0s = get_table_is_all_0s(table)
for i=1:1:size(table)
    vec = table(i,:);
    if(get_is_all_0s(vec) == 0)
        is_all_0s = 0;
        return;
    end
end
is_all_0s = 1;