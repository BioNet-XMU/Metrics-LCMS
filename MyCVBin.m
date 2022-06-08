function [cvX,cvBin] = MyCVBin(cvCV,nBin)
nVariable = length(cvCV);
cvCV = sort(cvCV,'ascend');
cvBin = zeros(nBin+1,1);
cvX   = zeros(nBin+1,1);
for i=1:nBin
    cvBin(i+1)=sum(cvCV<=(i/nBin))/nVariable;
    cvX(i+1)= 1.0*i/nBin;
end
cvBin(1)=0;
cvX(1)=0;
clear nVariable i;