clc
clear
load('evaluateGoodMethodRPCA_COIL100_2.mat')
COIL100_2= []


C= []
for i=1:length(numID)
    if(MIhat_Diff(i, 1)>MIhat_Original(i, 1))
        if(AC_Diff(i, 1)>AC_Original(i, 1))
            C=[i, methodName1_2(1,i), AC_Diff(i, 1), AC_Original(i, 1), MIhat_Diff(i, 1), MIhat_Original(i, 1)]
            COIL100_2= [COIL100_2; C]
            C=[]
        end
    end
end
save('goodMethod_RPCA_dataset', 'COIL100_2', '-append')
clc
clear