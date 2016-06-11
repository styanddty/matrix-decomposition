function [] = saveDecomposeImg(X, X_com, X_diff, X_err, fileName)
%Decompose img
M_X=X(:,[9,52,21,23])
M_C=X_com(:,[9,52,21,23])
M_D=X_diff(:,[9,52,21,23])
M_E=X_err(:,[9,52,21,23])
M_X=normalImg(M_X)
M_C=normalImg(M_C)
M_D=normalImg(M_D)
M_E=normalImg(M_E)
% max(max(M_X))-min(min(M_X))
faceW=32
faceH=32
h_fig =figure('Visible', 'off');

subplot(411);
Img=reshape(M_X,faceW,[]);
imagesc(Img);
axis image;
colormap(gray);
title('X');

subplot(412);
Img=reshape(M_C,faceW,[]);
imagesc(Img);
axis image;
colormap(gray);
title('C');

subplot(413);
Img=reshape(M_D,faceW,[]);
imagesc(Img);
axis image;
colormap(gray);
title('D');

subplot(414);
Img=reshape(M_E,faceW,[]);
imagesc(Img);
axis image;
colormap(gray);
title('E')
saveas(h_fig, fileName, 'jpg');
saveas(h_fig, fileName);