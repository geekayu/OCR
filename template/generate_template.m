clc,clear all    
[x,y]=imread('OCR-A.png'); % y:colormap
if isempty(y)==1
    z = ~im2bw(x);
else
    z = ~im2bw(x,y); % convert to binary 1 for alphabet 0 for space
end
%-------image boundary -----------
[row , col ] = find(z);
col_temp = unique(col);
row_temp = unique(row);
z_temp = z(min(row_temp):max(row_temp),min(col_temp):max(col_temp));
%------letter-----------------
temp_data = cell(1,62);
i=0;
while 1
    % target: a row/line at a time
    [temp_row,temp_col] = find(z_temp);
    if isempty(temp_row)==1
        break
    end
    temp_col = unique(temp_col);
    temp_row = unique(temp_row);
    [mini,maxx] = gen(temp_row);
    temp_z = z_temp(mini:maxx,:); % a complete row/line at a time
    z_temp(mini:maxx,:)=[]; % delete cuurent line
    % ---------target : a letter at a time------------
    while 1
        i=i+1;
        [row_letter,col_letter] = find(temp_z);
        if isempty(row_letter)==1
            i=i-1;
            break
        end
        row_letter = unique(row_letter);
        col_letter = unique(col_letter);
        [mini_l,maxx_l] = gen(col_letter);
        temp_letter = temp_z(:,mini_l:maxx_l); % get letter block
        temp_z(:,mini_l:maxx_l)=[];
        [x,y] = find(temp_letter);
        %----letter in its original dimensions,thus no more fixed dimensions-----
        letter = temp_letter(min(x):max(x),min(y):max(y));
        %temp_data(i)=letter;
        xl = size(letter);
        temp_cell = mat2cell(letter,[xl(1)],[xl(2)]);
        temp_data(1,i)=temp_cell;
        imshow(letter)
        input('e');
    end    
end
save('template_ocr_a','temp_data')
