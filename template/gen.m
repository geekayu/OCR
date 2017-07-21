% this function returns values for creating boundaries to image
function[min_val max_val] = gen(temp_array)
    min_val = min(temp_array);
    max_val = min_val;
    i=2;
    temp_size=size(temp_array);
    if temp_size(1)==1
        temp_size = temp_size(2);
    else
        temp_size = temp_size(1);
    end
    while i<=temp_size
        val = temp_array(i);
        if val == max_val+1
            max_val = val;
            i = i+1;
        else
            break        
        end        
    end
end
