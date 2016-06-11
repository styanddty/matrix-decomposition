clc
clear
load('goodMethod_RPCA_better')
list=goodMethodRPCA_better(:, 2)
goodMethodRPCA_better2=goodMethodRPCA_better
for j=1:length(list)
    str= char(list{j})
    p= findstr(str, '_')
    sp=p(1)
    str1=str(1:sp-1)
    str2= str(sp+1:length(str))
    goodMethodRPCA_better2{j,2}=str1
    goodMethodRPCA_better2{j,3}=str2
end
save('goodMethod_RPCA_better2','goodMethodRPCA_better2')