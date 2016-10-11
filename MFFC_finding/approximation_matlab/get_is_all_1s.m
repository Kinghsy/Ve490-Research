function is_all_1s = get_is_all_1s(vec)
if(sum(vec==0)==0)
    is_all_1s = 1;
else
    is_all_1s = 0;
end