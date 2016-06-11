clear
clc
load('Method_ALL.mat')
load('Method_nmf3.mat')
method_type='NMF'
method_list=method_nmf
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

our_nmf_list=method_all(B, :)
save('a_our_nmf_list', 'our_nmf_list')
data=load('a_our_nmf_list');
f=fieldnames(data);
for k=1:size(f,1)
    xlswrite('a_our_nmf_list.xlsx',data.(f{k}),f{k})
end