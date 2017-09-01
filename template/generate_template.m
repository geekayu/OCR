small_letter = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',...
                'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',...
                'u', 'v', 'w', 'x', 'y', 'z'};
capital_letter = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',...
                  'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',...
                  'U', 'V', 'W', 'X', 'Y', 'Z'};
numbers = {0,1,2,3,4,5,6,7,8,9};
numbers_alt = {1,2,3,4,5,6,7,8,9,0};
pattern = [small_letter,capital_letter,numbers];
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
template_data = cell(1,62);
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
        %template_data(i)=letter;
        xl = size(letter);
        temp_cell = mat2cell(letter,[xl(1)],[xl(2)]);
        pattern(2,i)=temp_cell;
        %imshow(letter)
        %input('check');
    end    
end
template_data = pattern;
newfilename = fullfile('template', 'template_ocr_a');
save(newfilename, 'template_data')
h = msgbox('Template Created Successfully');