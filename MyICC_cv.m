function [cvICC,cvX,cvZ] = MyICC_cv( matData,cvCV,nPt )
% cvICC = zeros(nPt,1);
% 
% matData(isnan(matData))=0;
% matData(isinf(matData))=0;
% cvX = linspace(0,1,nPt+1);
% cvZ = zeros(nPt,1);
% %cvX(1)=[];
% for i=1:nPt
% %    matTem = matData(cvCV<cvX(i),:);
%     cvIndex = (cvCV>cvX(i) & (cvCV<cvX(i+1)));
%     cvZ(i) = sum(cvIndex);
%     matTem = matData(cvIndex,:);
%     cvICC(i) = ICC(matTem,'A-1',0.05,1);
% end
% cvX(1)=[];

matData(isnan(matData))=0;
matData(isinf(matData))=0;

nPeak = size(matData,1);

cvICC = zeros(nPeak,1);
cvZ = zeros(nPeak,1);
cvX = linspace(0,1,nPt+1);
k=0;
for i=1:nPt
%    matTem = matData(cvCV<cvX(i),:);
    cvIndex = (cvCV>cvX(i) & (cvCV<=cvX(i+1)));
    nRepeat = sum(cvIndex);
    matTem = matData(cvIndex,:);
    cvICC(k+1:k+nRepeat) = ICC(matTem,'A-1',0.05,1);
    cvZ(k+1:k+nRepeat)   = mean([cvX(i),cvX(i+1)]);
    k=k+nRepeat;
end