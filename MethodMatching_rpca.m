clear
clc
load('Method_ALL.mat')
load('Method_RPCA3.mat')
method_type='RPCA'
method_list=method_rpca
A=method_all(:,[2, 3] )
B=[]
for j=1:length(method_list)
    for i=1:length(A)
        if(strcmp(method_type, strtrim(cell2mat(A(i, 1)))))
            if(strcmp(strtrim(cell2mat(method_list(j))), strtrim(cell2mat(A(i, 2)))))
                B=[B; i]
            end
        end
    end
end
B=sort(B)

our_rpca_list=method_all(B, :)
save('a_our_rpca_list', 'our_rpca_list')
data=load('a_our_rpca_list');
f=fieldnames(data);
for k=1:size(f,1)
    xlswrite('a_our_rpca_list.xlsx',data.(f{k}),f{k})
end