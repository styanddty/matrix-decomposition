function [] = saveClusteringImg(X, X_com, X_diff, fileName, gnd)
% function [] = saveClusteringImg(dim, X, X_com, X_diff, fileName, gnd)
% dim= [15: 20: 165]%yale
% dim= [20: 50: 400]%ORL
dim= [10:50:400]%yaleB
A=[]
for k= dim
    B=[]
    [base,mean,projX]= pcaimg(X,k)
    [base_com,mean_com,projX_com]= pcaimg(X_com,k)
    [base_diff,mean_diff,projX_diff]= pcaimg(X_diff,k)
    
    err_X= sum(diag(cov(projX)))
    err_C= sum(diag(cov(projX_com)))
    
    res_X = litekmeans(projX', size(unique(gnd), 1));
    res_X = bestMap(gnd, res_X);
    %=============  evaluate AC: accuracy ==============
    AC_X = length(find(gnd == res_X))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_X = MutualInfo(gnd,res_X);
    
    res_D = litekmeans(projX_diff', size(unique(gnd), 1));
    res_D = bestMap(gnd,res_D);
    %=============  evaluate AC: accuracy ==============
    AC_D = length(find(gnd == res_D))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_D = MutualInfo(gnd,res_D);
    
    B={k,err_C, err_X, AC_D, AC_X, MIhat_D, MIhat_X}
    A=[A; B]
end


plot_k= cell2mat(A(:,1))
plot_err_C= cell2mat(A(:,2))
plot_err_X= cell2mat(A(:,3))
plot_AC_D= cell2mat(A(:,4))
plot_AC_X= cell2mat(A(:,5))
plot_MIhat_D= cell2mat(A(:,6))
plot_MIhat_X= cell2mat(A(:,7))
h_fig1 =figure('Visible', 'off');
p1= plot(plot_k, plot_AC_D, '--om')
hold on
p2= plot(plot_k, plot_AC_X, '-or')
hold on
p3= plot(plot_k, plot_MIhat_D, '--+g')
hold on
p4= plot(plot_k, plot_MIhat_X, '-+b')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
title('k-means clustering' , 'fontsize', 20);
xlabel('dimensionality reduction', 'fontsize', 16);
legend([p1, p2, p3, p4], 'AC-diff', 'AC-original', 'MIhat-diff',  'MIhat-original');

saveas(h_fig1, [fileName,'1'], 'jpg');
saveas(h_fig1, [fileName,'1']);

h_fig2 =figure('Visible', 'off');
p5= plot(plot_k, plot_err_C, '--og')
hold on
p6= plot(plot_k, plot_err_X, '-+b')
set(gca, 'fontsize', 14);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
set(gca, 'LineWidth', 1.5);
title('k-means clustering' , 'fontsize', 20);
xlabel('dimensionality reduction', 'fontsize', 16);
legend([p5, p6], 'err-com',  'err-original');
saveas(h_fig2, [fileName,'2'], 'jpg');
saveas(h_fig2,[fileName,'2']);