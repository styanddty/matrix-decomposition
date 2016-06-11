clear
clc
load('Method_ALL.mat')
load('Method_mc3.mat')
method_type='MC'
method_list=method_mc
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

our_mc_list=method_all(B, :)
save('a_our_mc_list', 'our_mc_list')
data=load('a_our_mc_list');
f=fieldnames(data);
for k=1:size(f,1)
    xlswrite('a_our_mc_list.xlsx',data.(f{k}),f{k})
end