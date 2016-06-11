clc
clear
load('goodMethod_RPCA_dataset.mat')
% A1= COIL100(:, 1)
% A2= COIL100_2(:, 1)
% A1= COIL100(:,1)
% A2= COIL100_2(:, 1)
% A1= double(A1)
% A2= double(A2)
% A1=num2cell(str2double(A1))
% str2double(A1)
% c = intersect(A1, A2)
D20(1, :)=Yale(9,:)
D20(2, :)=YaleB(9,:)
D20(3, :)=YaleB2(6,:)
D20(4, :)=YaleB3(9,:)
D20(5, :)=ORL(6,:)
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

pictureName=['RPCA ' char(D20(1,2))]
x= 1:5
h_fig =figure('Visible', 'on');
subplot(211)
p1= plot(x,AC_diff, '-.g')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xtick',[1 2 3 4 5])
title('Example 1.2', 'fontsize', 20);
% xlabel('Time (Second)', 'fontsize', 16);
% ylabel('Amplitude', 'fontsize', 16);
hold on
% subplot(212)
p2= plot(x, AC_original, '+--r')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xticklabel',{'Yale','YaleB','YaleB2','YaleB3','ORL'})
title(pictureName, 'fontsize', 20);
% xlabel('Time (Second)', 'fontsize', 16);
% ylabel('Amplitude', 'fontsize', 16);
legend([p1, p2],'AC_diff', 'AC_original');


subplot(212)
p1= plot(x,MIhat_diff, '-.g')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xtick',[1 2 3 4 5])
title('Example 1.2', 'fontsize', 20);
% xlabel('Time (Second)', 'fontsize', 16);
% ylabel('Amplitude', 'fontsize', 16);
hold on
% subplot(212)
p2= plot(x, MIhat_original, '+--r')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xticklabel',{'Yale','YaleB','YaleB2','YaleB3','ORL'})
title(pictureName, 'fontsize', 20);
% xlabel('Time (Second)', 'fontsize', 16);
% ylabel('Amplitude', 'fontsize', 16);
legend([p1, p2],'MIhat_diff', 'MIhat_original');

saveas(h_fig,pictureName);