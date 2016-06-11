% value = [10, 20, 30, 40];
% name = {'a', 'b', 'c', 'd'};
% bar(value);
% set(gca, 'XTickLabel', name);
% plot(value,name)
x= 1:5
y= 3*rand(1,5)
y2= 2*rand(1, 5)
% subplot(211)
p1= plot(x,y, '-.g')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xtick',[1 2 3 4 5])
title('Example 1.2', 'fontsize', 20);
xlabel('Time (Second)', 'fontsize', 16);
ylabel('Amplitude', 'fontsize', 16);
hold on
% subplot(212)
p2= plot(x, y2, '+--r')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
set(gca,'xticklabel',{'aa','bb','cs','ds','es'})
title('Example 1.2', 'fontsize', 20);
xlabel('Time (Second)', 'fontsize', 16);
ylabel('Amplitude', 'fontsize', 16);
legend([p1, p2],'sin', 'cos');
