clear
start_up
parpool(4)
clc
dataset1=[pwd '\dataset\ORL_32x32.mat'];
load(dataset1)

faceW = 32; 
faceH = 32; 
X=fea';
method_name='LRR';
load('lrr_list.mat')
A1=[]
for i=1:length(lrrlist)
    for j=1:length(lrrlist)
    B=[]
    B=[lrrlist(i), lrrlist(j)]
    A1=[A1; B]
    end
end
algorithmlist=A1
% 
% for j=1:length(algorithmlist)
%     A=[]
%     str= char(algorithmlist{j})
%     p= findstr(str, '_')
%     sp=p(1)
%     str1=str(1:sp-1)
%     str2= str(sp+1:length(str))
%     goodMethod_RPCA2{j,1}=str1
%     goodMethod_RPCA2{j,2}=str2
% end
algorithm_start=1
algorithm_end=length(algorithmlist)
lrr_decompose_list=[]
for k=algorithm_start:algorithm_end
    A=[]
    algorithm_id1=algorithmlist{k, 1}
    algorithm_id2=algorithmlist{k, 2}
    algorithm_name=[algorithm_id1 '_' algorithm_id2];
    result1=process_matrix(method_name,algorithm_id1, X, []); 
    X_err=result1.S; 
    X_L=result1.L;
    min_X_L=min(min(X_L))
%     min_X_err=min(min(X_err))
%     min_min=min(min_X_L, min_X_err)
    if min_X_L<0
       X_L=X_L+abs(min_X_L);
%        X_err=X_L+abs(min_min)
    end  
    opts2.rows =size(X_L,1);
    opts2.cols=size(X_L,2);

    result2=process_matrix(method_name,algorithm_id2, X_L, []);
    
    X_com=result2.L;
    X_diff=result2.S;
    A={algorithm_id1, algorithm_id2, X, X_com, X_diff, X_err}
    lrr_decompose_list=[lrr_decompose_list; A]
    save('a_lrr_decomposeData','lrr_decompose_list', '-append')
end