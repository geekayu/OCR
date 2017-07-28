clc,clear all  
addpath('template')
[x,y]=imread('sample_images/numbers001.tif'); % y:colormap
if isempty(y)==1
    z = ~im2bw(x);
else
    z = ~im2bw(x,y); % convert to binary ,1 for alphabet 0 for space
end
[row , col ] = find(z);
col_temp = unique(col);
row_temp = unique(row);
z_temp = z(min(row_temp):max(row_temp),min(col_temp):max(col_temp));
%---cropped the image and now loading the templates
load template_ocr_a.mat
template_data = template_data(:,1:62); %---filter---
file_data = fopen('result.txt','wt');
while 1
    %-----get one line per loop-------
    [temp_row,temp_col] = find(z_temp);
    if isempty(temp_row)==1
        break
    end
    temp_col = unique(temp_col);
    temp_row = unique(temp_row);
    [mini,maxx] = gen(temp_row);
    temp_line = z_temp(mini:maxx,:); % a complete row/line at a time
    z_temp(mini:maxx,:)=[]; % delete cuurent line
    %-----working on particular line-----------
    [gap_row,gap_col] = find(temp_line);
    if isempty(gap_row)==1
        break
    end
    gap_row = unique(gap_row);
    gap_col = unique(gap_col);
       %------analyze no. of words in line--through space b/w letter-----
    gap_size = diff(gap_col); % estimating space occupied by letter
    gap_size = gap_size(find(gap_size~=1)); % getting space b/w letters
    no_of_letters = size(gap_size,1)+1;
    min_space = min(gap_size);
    line_content = [];
    gap_size = [gap_size;0];
    for loop = 1:no_of_letters        
        [row_letter,col_letter] = find(temp_line);
        if isempty(row_letter)==1
            break
        end
        row_letter = unique(row_letter);
        col_letter = unique(col_letter);
        [mini_l,maxx_l] = gen(col_letter);
        temp_letter = temp_line(:,mini_l:maxx_l); % get letter block
        temp_line(:,mini_l:maxx_l)=[];
        [x,y] = find(temp_letter);
        %letter in its original dimensions,thus no more fixed dimensions
        letter = temp_letter(min(x):max(x),min(y):max(y));
        %imshow(letter)
        r_max = 0;
        for i =1:1:62 %---> value of i <------filter--------
            template_script = cell2mat(template_data(2,i));
            resized_letter = imresize(letter,size(template_script));
            r = corr2(template_script,resized_letter);
            if r>r_max
                r_max = r;
                let = template_data(1,i);
            end
        end
        result = cell2mat(let); 
        %-----amount of sapce calculated---------
        space_content='';
        space = gap_size(loop,1)/min_space-1;
        if space>1
            space_content = repmat(' ',1,floor(space/2));
        end
        line_content = [line_content,num2str(result),space_content];
        
    end 
    fprintf(file_data,'%s\n',line_content);
end
fclose(file_data);
winopen('result.txt')
rmpath('template')