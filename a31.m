
clc
clear
load('goodMethod_RPCA_dataset.mat')
output=[pwd '\output_rpca2\bar'];
if exist(output,'dir')==0
   mkdir(output);
end

D20(1, :)=Yale(15,:)
D20(2, :)=YaleB(15,:)
D20(3, :)=YaleB2(10,:)
D20(4, :)=YaleB3(14,:)
D20(5, :)=ORL(10,:)
AC_diff=zeros(5, 1)

for i=1:5
    AC_diff(i, 1)=D20{i, 3}
end

for i=1:5
    AC_original(i, 1)=D20{i, 4}
end

for i=1:5
    MIhat_diff(i, 1)=D20{i, 5}
end

for i=1:5
    MIhat_original(i, 1)=D20{i, 6}
end

pictureName=char(D20(1,2))
str= char(pictureName)
p= findstr(str, '_')
sp=p(1)
str1=str(1:sp-1)
str2= str(sp+1:length(str))
pictureName=[str1 ' ' str2]
fileName=fullfile(output,pictureName);
h_fig =figure('Visible', 'on');
subplot(211)
b1= bar([AC_diff, AC_original])
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xticklabel',{'Yale','YaleB','YaleB2','YaleB3','ORL'})
title(pictureName, 'fontsize', 20);
legend('AC-diff', 'AC-original');


subplot(212)
b2= bar([MIhat_diff, MIhat_original])
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xticklabel',{'Yale','YaleB','YaleB2','YaleB3','ORL'})
legend('MIhat-diff', 'MIhat-original');

saveas(h_fig,fileName);
saveas(h_fig,fileName, 'jpg');