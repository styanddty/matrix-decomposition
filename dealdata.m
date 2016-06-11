clear
clc
% load('C:\Users\Administrator\Documents\MATLAB\rpcaandrpca\dataset\ORL_32x32.mat')
load('C:\Users\Administrator\Documents\MATLAB\matrixfactorization_xcde\dataset\ORL_32x32.mat')

faceW = 32; 
faceH = 32; 
numPerLine = 4; 
ShowLine = 1;
Y=fea';
Y_length=size(Y,2);
filepath='D:\output4\ORLsample';
mkdir(filepath);
% [A, E, tol]=alm(Y);
% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
i=10;
% for i=1:Y_length
X=Y(:,[9,52,21,23]);
% X=X(:,1:5);
X=reshape( X,faceH,[]);
h_fig =figure('Visible', 'off');
imagesc(X);
colormap(gray);
% imshow(Y);
axis image;
fileformat1='jpg';
% fileformat2='fig';
num=num2str(i);
filename=fullfile(filepath,[ 'ORL_' num]);

% mkdir(filename);
saveas(h_fig,filename,fileformat1);
% saveas(h_fig,filename,fileformat2);
% end