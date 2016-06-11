clear
start_up
clc
dataset='C:\Users\Administrator\Documents\MATLAB\matrixfactorization_xcde\dataset\Yale_32x32.mat';
load(dataset)
method_name='NMF';
faceW = 32; 
faceH = 32; 
% numPerLine = 5; 
% ShowLine = 4; 

% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
% 
% imagesc(Y);
% colormap(gray);
%faceW=64; faceH=64;
% Img=reshape(X(:,1),64,64);imagesc(Img);colormap(gray);
X=fea';
X=X(:,1:5);
% opts1.rows =size(X,1);
% opts1.cols=size(X,2);
load('nmf_list.mat');
listlength=size(nmflist,2);
for i=1:listlength
    for j=1:listlength
algorithm_id1=nmflist{i};
% algorithm_id1='FPCP';
algorithm_id2=nmflist{j};
% algorithm_id2='FPCP';
algorithm_name=[algorithm_id1 '_' algorithm_id2];
result1=process_matrix(method_name,algorithm_id1, X, []);
X_noise=result1.S;

X_L=result1.L;
% opts2.rows =size(X_L,1);
% opts2.cols=size(X_L,2);
result2=process_matrix(method_name,algorithm_id2, X_L, []);
X_comm=result2.L;
X_diff=result2.S;

if min(min(X_comm))<0
    X_comm=X_comm+abs(min(min(X_comm)));
end   
if min(min(X_diff))<0
    X_diff=X_diff+abs(min(min(X_diff)));
end    
if min(min(X_noise))<0
    X_noise=X_noise+abs(min(min(X_noise)));
end   
% h_fig = figure('Visible', 'on','Name','test');

h_fig =figure('Visible', 'off');

subplot(221);
Img=reshape(X,faceW,[]);
imagesc(Img);
colormap(gray);
title('X');

subplot(222);
Img=reshape(X_comm,faceW,[]);
imagesc(Img);
colormap(gray);
title('C');

subplot(223);
Img=reshape(X_diff,faceW,[]);
imagesc(Img);
colormap(gray);
title('D');

subplot(224);
Img=reshape(X_noise,faceW,[]);
imagesc(Img);colormap(gray);
title('E')



fileformat1='jpg';
fileformat2='fig';
filename=fullfile(filepath,[algorithm_id1,'_',algorithm_id2]);
% mkdir(filename);
saveas(h_fig,filename,fileformat1);
saveas(h_fig,filename,fileformat2);

displog([algorithm_id1 '_' algorithm_id1 '--end']);
    end
end
