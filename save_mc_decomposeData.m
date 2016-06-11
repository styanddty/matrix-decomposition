clear
start_up
parpool(4)
clc
dataset1=[pwd '\dataset\ORL_32x32.mat'];
load(dataset1)

faceW = 32; 
faceH = 32; 
X=fea';
method_name='MC';
load('mc_list.mat')
A1=[]
for i=1:length(mclist)
    for j=1:length(mclist)
    B=[]
    B=[mclist(i), mclist(j)]
    A1=[A1; B]
    end
end
algorithmlist=A1
algorithm_start=1
algorithm_end=length(algorithmlist)
mc_decompose_list=[]
save('a_mc_decomposeData','mc_decompose_list')
for k=algorithm_start:algorithm_end
    A=[]
    algorithm_id1=algorithmlist{k, 1}
    algorithm_id2=algorithmlist{k, 2}
    algorithm_name=[algorithm_id1 '_' algorithm_id2];
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
    A={algorithm_id1, algorithm_id2, X, X_com, X_diff, X_err}
    mc_decompose_list=[mc_decompose_list; A]
    save('a_mc_decomposeData','mc_decompose_list', '-append')
end