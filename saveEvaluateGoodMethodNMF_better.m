clear
start_up
parpool(4)
clc
% dataset1=[pwd '\dataset\ORL_32x32.mat'];
% dataset1=[pwd '\dataset\Yale_32x32.mat'];
dataset1=[pwd '\dataset\YaleB_32x32.mat'];
load(dataset1)
randlist=round(rand(1, 400)*size(fea, 1))%yaleB
fea= fea(randlist, :)%yaleB
gnd= gnd(randlist, :)%yaleB


% output=[pwd '\output_nmf\ORL'];
% output=[pwd '\output_nmf\Yale'];
output=[pwd '\output_nmf\YaleB'];
if exist(output,'dir')==0
   mkdir(output);
end

faceW = 32; 
faceH = 32; 

X=fea';
method_name='NMF';
load('goodMethod_nmf.mat')
algorithmlist=goodMethod_nmf
algorithm_start=1
algorithm_end=length(algorithmlist)
for i=algorithm_start:algorithm_end
    algorithm_id1=algorithmlist{i, 1}
    algorithm_id2=algorithmlist{i, 2}
    algorithm_name=[algorithm_id1 '_' algorithm_id2];
    fileName=fullfile(output,algorithm_name);
    result1=process_matrix(method_name,algorithm_id1, X, []); 
    X_err=result1.S; 
    X_L=result1.L;
    min_X_L=min(min(X_L))
    if min_X_L<0
         X_L=X_L+abs(min_X_L);
    end
    opts2.rows =size(X_L,1);
    opts2.cols=size(X_L,2);
   
    result2=process_matrix(method_name,algorithm_id2, X_L, []);
    
    X_com=result2.L;
    X_diff=result2.S;
    saveDecomposeImg(X, X_com, X_diff, X_err, fileName)
    saveClusteringImg(X, X_com, X_diff, fileName, gnd)
end