clear
clc
load('C:\Users\Administrator\Documents\MATLAB\matrixfactorization_xcde\dataset\ORL_32x32.mat')
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
X=fea'
Label=gnd
[coeff,score,latent]=princomp(X');
contribution1=cumsum(latent)./sum(latent);
%% display data and approximate
ID=172;
p=399;  % 162 - Yale; 399 - ORL
Img=X(:,ID);
newX=coeff(:,1:p)*score(:,1:p)';
L_comm=Img-newX(:,ID);
index=find(Label==Label(ID));
ID_index=find(index==ID);
newXX=coeff(:,1:p)*score(index,1:p)';
[coeff,score,latent]=princomp(newXX');
contribution2=cumsum(latent)./sum(latent);
p=9; %9-ORL
L_noise=coeff(:,1:p)*score(ID_index,1:p)';
L_diff=newXX(:,ID_index)-L_noise;

subplot(141)
Img=reshape(Img,faceW,faceH);
imagesc(Img);colormap(gray);
title('X')

subplot(142)
Img=reshape(L_comm,faceW,faceH);
imagesc(Img);colormap(gray);
title('C')

subplot(143)
Img=reshape(L_diff,faceW,faceH);
imagesc(Img);colormap(gray);
title('D')

subplot(144)
Img=reshape(L_noise,faceW,faceH);
imagesc(Img);colormap(gray);
title('E')

