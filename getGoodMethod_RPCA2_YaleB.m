clc
clear
% load('evaluateGoodMethodRPCA_Yale.mat')
% Yale= []
load('evaluateGoodMethodRPCA_YaleB.mat')
YaleB= []
% load('evaluateGoodMethodRPCA_YaleB2.mat')
% YaleB2= []
% load('evaluateGoodMethodRPCA_YaleB3.mat')
% YaleB3= []
% load('evaluateGoodMethodRPCA_ORL.mat')
% ORL= []

C= []
for i=1:length(numID)
    if(MIhat_Diff(i, 1)>MIhat_Original(i, 1))
        if(AC_Diff(i, 1)>AC_Original(i, 1))
            C=[i, methodName1_2(1,i), AC_Diff(i, 1), AC_Original(i, 1), MIhat_Diff(i, 1), MIhat_Original(i, 1)]
%             Yale= [Yale; C]
              YaleB= [YaleB; C]
            C=[]
        end
    end
end

% D=[]
% for j=1: size(A, 1)
%     x=A(j, 1)/27
%     x=round(x)+1
%     y=mod(A(j, 1), 27)
%     D=[D; [x, y]]
% end
% dex=D(:,1)
% dey=D(:,2)
% goodMethod_RPCA=[]
% for k=A
%     goodMethod_RPCA=[goodMethod_RPCA; methodName1_2(1, k)]
% end
% goodMethod_RPCA=goodMethod_RPCA'
% 
% save('goodMethod_RPCA', 'goodMethod_RPCA')
% save('goodMethod_RPCA_dataset', 'Yale', '-append')
save('goodMethod_RPCA_dataset', 'YaleB', '-append')
clc
clear