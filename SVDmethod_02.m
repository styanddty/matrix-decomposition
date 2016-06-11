clear
start_up
% parpool(4)
clc
dataset1=[pwd '\dataset\ORL_32x32.mat'];
load(dataset1)

output=[pwd '\output_svd4\ORL'];
if exist(output,'dir')==0
    mkdir(output)
end
faceW = 32;
faceH = 32;

X=fea';
method_name='SVD';

fileName=fullfile(output,method_name);
%¾ØÕó·Ö½â
[U S V]= svd(X)
F= diag(S)
high= F(1)-F(length(F))
high2=0.2*high
high3= 0.01*high
F1=find(F>high2)
F2=find(F>high3)
k1=F1(length(F1))+1
k2=F2(length(F2))+1
X_com= U(:, 1:k1)*S(1:k1, :)*V'
X_diff= U(:, k1+1:k2)*S(k1+1:k2, :)*V'
X_err=X-X_com-X_diff

saveDecomposeImg(X, X_com, X_diff, X_err, fileName)
% dim= [20: 50: 400]%ORL
saveClusteringImg( X, X_com, X_diff, fileName, gnd)



