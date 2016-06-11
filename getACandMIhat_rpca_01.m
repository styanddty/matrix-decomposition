clear
start_up
parpool(4)
clc
dataset1=[pwd '\dataset\ORL_32x32.mat'];
load(dataset1)
method_name='RPCA';
% method_name='LRR';
% method_name='MC';

% method_name='NMF';
% filepath=['D:\output6\', method_name];
% if exist(filepath,'dir')==0
%    mkdir(filepath);
% end

faceW = 32; 
faceH = 32; 

% X=fea';
X=fea';
% N=size(gnd, 1)
% X=X(:,1:N);
% gnd2=gnd(1:N)

% load('nmf_list.mat');
% algorithmlist=nmflist;
% 
% load('lrr_list.mat');
% algorithmlist=lrrlist;

load('algorithm_rpca_list.mat');
% algorithmlist=algorithmlist;
listlength=size(algorithmlist,2);

MIhat_Original= [];
MIhat_Diff= [];
AC_Original= [];
AC_Diff= [];
% methodName= [];
% methodName1_2= [];
numID= [];
num_id= 0;
% listlength=2
for i=1:listlength
    algorithm_id1=algorithmlist{i};   
    result1=process_matrix(method_name,algorithm_id1, X, []);
      
    if min(min(result1.S))<0
       result1.S=result1.S+abs(min(min(result1.S)));
    end   
    if min(min(result1.L))<0
       result1.L=result1.L+abs(min(min(result1.L)));
    end   
    
    X_noise=round(result1.S); 
    X_L=round(result1.L);
    opts2.rows =size(X_L,1);
    opts2.cols=size(X_L,2);
    
    for j= 1:listlength
    
    % algorithm_id1='FPCP';
    % algorithm_id2=algorithmlist{2};
    algorithm_id2=algorithmlist{j};
    % algorithm_id2='FPCP';
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
 


    % h_fig =figure('Visible', 'off');
    % 
    % subplot(221);
    % Img=reshape(X,faceW,[]);
    % imagesc(Img);
    % colormap(gray);
    % title('X');
    % 
    % subplot(222);
    % Img=reshape(result1.L,faceW,[]);
    % imagesc(Img);
    % colormap(gray);
    % title('L');
    % 
    % subplot(223);
    % Img=reshape(result1.S,faceW,[]);
    % imagesc(Img);
    % colormap(gray);
    % title('S');

    % subplot(224);
    % Img=reshape(X_noise,faceW,[]);
    % imagesc(Img);colormap(gray);
    % title('E')



    % fileformat1='jpg';
    % fileformat2='fig';
    % filename=fullfile(filepath, algorithm_id1);
    % 
    % saveas(h_fig,filename,fileformat1);
    % saveas(h_fig,filename,fileformat2);
    
    res_X = kmeans(X', size(unique(gnd), 1));
    res_X = bestMap(gnd, res_X);
    %=============  evaluate AC: accuracy ==============
    AC_X = length(find(gnd == res_X))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_X = MutualInfo(gnd,res_X);

    if  sum(sum(isnan(X_diff')))>0
        AC_D= 0
        MIhat_D= 0
    else
        res_D = kmeans(X_diff', size(unique(gnd), 1));
        res_D = bestMap(gnd,res_D);
    %=============  evaluate AC: accuracy ==============
        AC_D = length(find(gnd == res_D))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
        MIhat_D = MutualInfo(gnd,res_D);
    end
    displog([algorithm_id1 '_' algorithm_id1 '<-->end']);
    
    num_id=num_id+1;
    
    MIhat_Original= [MIhat_Original; MIhat_X];
    AC_Original= [AC_Original; AC_X];
    
    MIhat_Diff= [MIhat_Diff; MIhat_D];  
    AC_Diff= [AC_Diff; AC_D]
    
    methodName{num_id}=  method_name;
    methodName1_2{num_id}= algorithm_name;
    numID=[numID; num_id];
    
    methodName= methodName';
    methodName1_2= methodName1_2';    
    save('ACandMIhat_rpca5','MIhat_Original','MIhat_Diff','AC_Original','AC_Diff', 'methodName', 'methodName1_2', 'numID') 
    end
end
   
%  data=load('ACandMIhat5');
%  f=fieldnames(data);
%  for k=1:size(f,1)
%    xlswrite('ACandMIhat5.xlsx',data.(f{k}),f{k})
%  end