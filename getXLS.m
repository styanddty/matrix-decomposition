
%  data=load('ACandMIhat_lrr');
%  f=fieldnames(data);
%  for k=1:size(f,1)
%    xlswrite('ACandMIhat_lrr.xlsx',data.(f{k}),f{k})
%  end
%   data=load('ACandMIhat_nmf');
%  f=fieldnames(data);
%  for k=1:size(f,1)
%    xlswrite('ACandMIhat_nmf.xlsx',data.(f{k}),f{k})
%  end

 
 data=load('algorithm_rpca_list');
 f=fieldnames(data);
 for k=1:size(f,1)
   xlswrite('algorithm_rpca_list.xlsx',data.(f{k}),f{k})
 end