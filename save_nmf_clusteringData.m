clear
start_up
parpool(4)
clc
dataset1=[pwd '\dataset\ORL_32x32.mat'];
load(dataset1)
load('a_nmf_decomposeData.mat')
method_name='NMF';

algorithmlist=nmf_decompose_list

algorithm_start=1
algorithm_end=length(algorithmlist)
% algorithm_end=1
nmf_clustering_list=[]
 save('a_nmf_clusteringData','nmf_clustering_list')
for i=algorithm_start:algorithm_end
    B=[]
%     A={algorithm_id1, algorithm_id2, X, X_com, X_diff}
    algorithm_id1=algorithmlist{i,1}
    algorithm_id2=algorithmlist{i,2}
    X_original=algorithmlist{i,3}
    X_com=algorithmlist{i,4}
    X_diff=algorithmlist{i,5}
    X_err=algorithmlist{i,6}
    err_X= sum(diag(cov(X_original)))
    err_C= sum(diag(cov(X_com)))
    
    res_X = litekmeans(X_original', size(unique(gnd), 1));
    res_X = bestMap(gnd, res_X);
    %=============  evaluate AC: accuracy ==============
    AC_X = length(find(gnd == res_X))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_X = MutualInfo(gnd,res_X);
    
    res_D = litekmeans(X_diff', size(unique(gnd), 1));
    res_D = bestMap(gnd,res_D);
    %=============  evaluate AC: accuracy ==============
    AC_D = length(find(gnd == res_D))/length(gnd);
    %=============  evaluate MIhat: nomalized mutual information =================
    MIhat_D = MutualInfo(gnd,res_D);
    
    B={algorithm_id1, algorithm_id2,err_C, err_X, AC_D, AC_X, MIhat_D, MIhat_X}
    
    nmf_clustering_list=[nmf_clustering_list; B]
    save('a_nmf_clusteringData','nmf_clustering_list', '-append')
end
  data=load('a_nmf_clusteringData');
 f=fieldnames(data);
 for k=1:size(f,1)
   xlswrite('a_nmf_clusteringData.xlsx',data.(f{k}),f{k})
 end