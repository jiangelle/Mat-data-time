tic %保存当前时间
load TDT2.mat
fid = fopen('data_tag.txt' , 'w');
fea = sortrows(fea,36773);%文档按照时间重新排序
num_times = fix((fea(end,end)-fea(1,end))/100)+1;%得到文档切片的时间点个数
fprintf(fid , [num2str(num_times) '\n']);%num2str(A)将数组A中的数转化为字符串

row = 0;
count = zeros(1,num_times);%记录每个时间点的最后一行的行数
[a,b] = size(fea);
for t = 1:num_times
    row = row + 1;
    while(true)
        if ( row ~= a )
            if(fix(fea(row,end)/100) ~= fix(fea(row+1,end)/100)) 
                break;%按月对文档进行切片
            else
                row = row + 1;
            end
        else 
            break;
        end
    end
    count(t) = row;%用count数组记录每一个片的最后一行行数
    if (t == 1)
        fprintf(fid , [num2str(fix(fea(1,end)/100)+t-1) ' ' num2str(count(t)) '\n']);
    else
        fprintf(fid , [num2str(fix(fea(1,end)/100)+t-1) ' ' num2str(count(t)-count(t-1)) '\n']);
    end
    if (t == 1)
        for line = 1:count(t)
            data = find(fea(line,:)~=0);
            word = nonzeros(fea(line,:));
            [i,j] = size(data);
            fprintf(fid, [num2str(j-2) ' ']);
            for num = 1:j-2
                fprintf(fid, [num2str(data(num)) ':' num2str(word(num)) ' ' ]);
            end
            fprintf(fid ,[num2str(word(end-1)) '\n']);
            %fprintf(fid, '\n');
        end
    else
        for line = (count(t-1)+1):count(t)
            data = find(fea(line,:)~=0);
            word = nonzeros(fea(line,:));
            [m,n] = size(data);
            fprintf(fid, [num2str( n-2 ) ' ']);
            for num = 1:n-2
                fprintf(fid,[num2str(data(num)) ':' num2str(word(num)) ' ' ]);
            end
            fprintf(fid ,[num2str(word(end-1)) '\n']);
            %fprintf(fid, '\n');
        end
    end
    toc
end
fclose(fid);