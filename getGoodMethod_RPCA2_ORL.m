clc
clear
load('evaluateGoodMethodRPCA_ORL.mat')
ORL= []


C= []
for i=1:length(numID)
    if(MIhat_Diff(i, 1)>MIhat_Original(i, 1))
        if(AC_Diff(i, 1)>AC_Original(i, 1))
            C=[i, methodName1_2(1,i), AC_Diff(i, 1), AC_Original(i, 1), MIhat_Diff(i, 1), MIhat_Original(i, 1)]
            ORL= [ORL; C]
            C=[]
        end
    end
end
save('goodMethod_RPCA_dataset', 'ORL', '-append')
clc
clear