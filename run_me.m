tic %���浱ǰʱ��
load TDT2.mat
fid = fopen('data_tag.txt' , 'w');
fea = sortrows(fea,36773);%�ĵ�����ʱ����������
num_times = fix((fea(end,end)-fea(1,end))/100)+1;%�õ��ĵ���Ƭ��ʱ������
fprintf(fid , [num2str(num_times) '\n']);%num2str(A)������A�е���ת��Ϊ�ַ���

row = 0;
count = zeros(1,num_times);%��¼ÿ��ʱ�������һ�е�����
[a,b] = size(fea);
for t = 1:num_times
    row = row + 1;
    while(true)
        if ( row ~= a )
            if(fix(fea(row,end)/100) ~= fix(fea(row+1,end)/100)) 
                break;%���¶��ĵ�������Ƭ
            else
                row = row + 1;
            end
        else 
            break;
        end
    end
    count(t) = row;%��count�����¼ÿһ��Ƭ�����һ������
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