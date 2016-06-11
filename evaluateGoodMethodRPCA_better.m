clear
start_up
parpool(4)
clc
dataset1=[pwd '\dataset\ORL_32x32.mat'];
% dataset1=[pwd '\dataset\Yale_32x32.mat'];
% dataset1=[pwd '\dataset\YaleB_32x32.mat'];
load(dataset1)
% randlist=round(rand(1, 400)*size(fea, 1))%yaleB
% fea= fea(randlist, :)%yaleB
% gnd= gnd(randlist, :)%yaleB
method_name='RPCA';

output=[pwd '\output_rpca\ORL'];
if exist(output,'dir')==0
   mkdir(output);
end

faceW = 32; 
faceH = 32; 

X=fea';
method_name='RPCA';


load('goodMethod_RPCA_better2')
algorithmlist=goodMethodRPCA_better2
% dim= [10: 20: 400]%ORL
% %yale
% dim=[10:20:165]
% dim= [10:50:400]%yaleB
% dim= [10:20:400]%yale

for i=1:length(algorithmlist)
    A=[]
    for k= dim
    B=[]
    [base,mean,projX]= pcaimg(X,k)
    
    algorithm_id1= cell2mat(algorithmlist(i, 2))
    algorithm_id2= cell2mat(algorithmlist(i, 3))
    result1=process_matrix(method_name,algorithm_id1, projX, []);
      
    if min(min(result1.S))<0
       result1.S=result1.S+abs(min(min(result1.S)));
    end   
    if min(min(result1.L))<0
       result1.L=result1.L+abs(min(min(result1.L)));
    end   
    
    X_noise=round(result1.S); 
    X_L=result1.L;
    opts2.rows =size(X_L,1);
    opts2.cols=size(X_L,2);
    

    algorithm_name=[algorithm_id1 '_' algorithm_id2];
  
    result2=process_matrix(method_name,algorithm_id2, X_L, []);
    
    if min(min(result2.S))<0
       result2.S=result2.S+abs(min(min(result2.S)));
    end   
    if min(min(result2.L))<0
       result2.L=result2.L+abs(min(min(result2.L)));
    end 
    
    X_comm=round(result2.L);
    X_diff=round(result2.S);
 
    err_X= sum(diag(cov(projX)))
    err_D= sum(diag(cov(X_diff)))
    
    res_X = kmeans(projX', size(unique(gnd), 1));
    res_X = bestMap(gnd, res_X);
    %=============  evaluate AC: accuracy ==============
    AC_X = length(find(gnd == res_X))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_X = MutualInfo(gnd,res_X);

    res_D = kmeans(X_diff', size(unique(gnd), 1));
    res_D = bestMap(gnd,res_D);
    %=============  evaluate AC: accuracy ==============
    AC_D = length(find(gnd == res_D))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_D = MutualInfo(gnd,res_D);
    
    B={k, algorithm_id1, algorithm_id2, err_D, err_X, AC_D, AC_X, MIhat_D, MIhat_X}
    A=[A; B]   
    end
    h_fig =figure('Visible', 'off');
%     subplot(211)
    plot_k= cell2mat(A(:,1))
    first= cell2mat(A(1,2))
    second= cell2mat(A(1,3))
    plot_AC_D= cell2mat(A(:,6)) 
    plot_AC_X= cell2mat(A(:,7))
    plot_MIhat_D= cell2mat(A(:,8)) 
    plot_MIhat_X= cell2mat(A(:,9))
    
    pictureName=fullfile(output,[first '_' second]);
    
    p1= plot(plot_k, plot_AC_D, '-om')
    hold on
    
    p2= plot(plot_k, plot_AC_X, '-or')
    hold on 
    
    p3= plot(plot_k, plot_MIhat_D, '-+g')
    hold on
    
    p4= plot(plot_k, plot_MIhat_X, '-+b')
    set(gca, 'fontsize', 14);
    set(gca, 'XMinorTick', 'on');
    set(gca, 'YMinorTick', 'on');
    set(gca, 'XGrid', 'on');
    set(gca, 'YGrid', 'on');
    set(gca, 'LineWidth', 1.5);
    title([ first, '    ' second], 'fontsize', 20);
    xlabel('dim', 'fontsize', 16);
%     ylabel('Amplitude', 'fontsize', 16);
%     hold on
    
    legend([p1, p2, p3, p4], 'AC-D', 'AC-X', 'MIhat-D',  'MIhat-X');
    saveas(h_fig,pictureName, 'jpg');
    saveas(h_fig,pictureName);
end