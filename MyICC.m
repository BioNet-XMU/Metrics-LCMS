function [cvICC,cvX] = MyICC( matData,cvMedian,nPt )
cvICC = zeros(nPt,1);
nPeak = size(matData,1);
matData(isnan(matData))=0;
matData(isinf(matData))=0;
cvX = ones(nPt,1);
for i=1:nPt
    iPos = ceil(nPeak*i/nPt);
    cvICC(i) = ICC(matData(1:iPos,:),'A-1',0.05,1);
    cvX(i) = cvMedian(iPos);
end
clear nPeak i;