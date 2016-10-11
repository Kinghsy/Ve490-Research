function is_equal = is_two_vec_equal(vec1,vec2)
is_equal = 0;
if(length(vec1)~=length(vec2))
    return;
else
    for i=1:1:length(vec1)
        if(vec1(i)~=vec2(i))
            return;
        end
    end
    is_equal = 1;
    return;
end