clc
clear
load('goodMethod_RPCA_dataset.mat')

A1=cell2mat(Yale(:, 1))
A2=cell2mat(YaleB(:, 1))
A3=cell2mat(YaleB2(:, 1))
A4=cell2mat(YaleB3(:, 1))
A5=cell2mat(ORL(:, 1))
result1= intersect(A1, A2)
result2= intersect(A3, A4)
result3= intersect(result1, result2)
goodM= intersect(result3, A5)

goodName=[]
dataset=Yale
for j=1:length(goodM)
    for i=1:size(dataset, 1)
        if(cell2mat(dataset(i, 1)) == goodM(j) )
            goodName=[goodName, i]
        end
    end
end
% d=[20, 24, 30, 31, 36, 37, 42, 43]
goodMethodRPCA_better=Yale(goodName, :)
save('goodMethod_RPCA_better','goodMethodRPCA_better' )
% % A= []
% B= []
% C= []
% dataset=Yale
% for i=1:size(dataset, 1)
%     if(cell2mat(dataset(i, 3))>cell2mat(dataset(i, 4)))
%         if(cell2mat(dataset(i, 5))>cell2mat(dataset(i, 6)))
%               C=dataset(i, :)
%               B= [B; C]
%               C=[]
%         end
%     end
% end


% B2= []
% C2= []
% dataset=YaleB
% for i=1:size(dataset, 1)
%     if(cell2mat(dataset(i, 3))>cell2mat(dataset(i, 4)))
%         if(cell2mat(dataset(i, 5))>cell2mat(dataset(i, 6)))
%               C2=dataset(i, :)
%               B2= [B2; C2]
%               C2=[]
%         end
%     end
% end