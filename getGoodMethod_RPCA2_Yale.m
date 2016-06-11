clc
clear
load('evaluateGoodMethodRPCA_Yale.mat')
Yale= []

C= []

for i=1:length(numID)
    if(MIhat_Diff(i, 1)>MIhat_Original(i, 1))
        if(AC_Diff(i, 1)>AC_Original(i, 1))
            C=[i, methodName1_2(1,i), AC_Diff(i, 1), AC_Original(i, 1), MIhat_Diff(i, 1), MIhat_Original(i, 1)]
            Yale= [Yale; C]
            C=[]
        end
    end
end

save('goodMethod_RPCA_dataset', 'Yale', '-append')