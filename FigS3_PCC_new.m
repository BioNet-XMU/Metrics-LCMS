clear
clc

load('new_Data.mat');
load('OffSet.mat');

f = fittype('a*log(x)+b'); %  formula of the fitting curve  

nPt = 500;
[matCorr1,cvMedian1] = GetCorrelation(matData1,nPt);
[matCorr2,cvMedian2] = GetCorrelation(matData2,nPt);
[matCorr3,cvMedian3] = GetCorrelation(matData3,nPt);
[matCorr4,cvMedian4] = GetCorrelation(matData4,nPt);

nPeak1=size(matData1,1);
nPeak2=size(matData2,1);
nPeak3=size(matData3,1);
nPeak4=size(matData4,1);
cvPos1 = ceil(nPeak1*(1:nPt)/nPt);
cvPos2 = ceil(nPeak2*(1:nPt)/nPt);
cvPos3 = ceil(nPeak3*(1:nPt)/nPt);
cvPos4 = ceil(nPeak4*(1:nPt)/nPt);

cvX1 = log10(cvMedian1)-dbOffSet1;
cvX2 = log10(cvMedian2)-dbOffSet2;
cvX3 = log10(cvMedian3)-dbOffSet3;
cvX4 = log10(cvMedian4)-dbOffSet4;

x1 = cvX1(cvPos1);
x2 = cvX2(cvPos2);
x3 = cvX3(cvPos3);
x4 = cvX4(cvPos4);

cvSam = 0:25:500;
cvSam(1)=[];
x1 = x1(cvSam);
x2 = x2(cvSam);
x3 = x3(cvSam);
x4 = x4(cvSam);

y1 = median(matCorr1);
y2 = median(matCorr2);
y3 = median(matCorr3);
y4 = median(matCorr4);

y1 = y1(cvSam);
y2 = y2(cvSam);
y3 = y3(cvSam);
y4 = y4(cvSam);

y1(isnan(y1))=0;
y1(isinf(y1))=0;
y2(isnan(y2))=0;
y2(isinf(y2))=0;
y3(isnan(y3))=0;
y3(isinf(y3))=0;
y4(isnan(y4))=0;
y4(isinf(y4))=0;

figure


plot(x1,y1,'r','LineWidth',2); hold on
plot(x2,y2,'g','LineWidth',2);
plot(x3,y3,'b','LineWidth',2);
plot(x4,y4,'k','LineWidth',2);
xlabel('Normalized lg(Abundance)');

plot([0,0],[0,1],'--r','LineWidth',1.5);

hold off
legend(' 6545P',' 6545C',' 6520P',' 6520C');
ylabel('PCC');

set(gca,'Fontsize',14,'FontName','Arial','FontWeight','Bold','ylim',[0.2,1.02],'xlim',[-4.5,4.5]);

%set(gca,'Fontsize',14,'FontName','Arial','FontWeight','Bold','ylim',[0,1.02]);%,'xlim',[0,100]);
set(gcf,'position',[200,200,800,600]);

mean(y1)
mean(y2)
mean(y3)
mean(y4)

y1(10)
y2(10)
y3(10)
y4(10)


function [matCorr,cvMedian,cvInd] = GetCorrelation(matData,nPt)
% _ExcludeMissValue
[nPeak,nSample] = size(matData);
cvMedian= zeros(nPeak,1);
for i=1:nPeak
    rvTem = matData(i,:);
    rvTem(rvTem<1) = [];
    cvMedian(i) = median(rvTem);
end

% 调整行顺序，从小到大排列
[cvMedian,cvInd] = sort(cvMedian,'ascend');
matData = matData(cvInd,:);
matTem  = log10(matData);
matTem(matData<1)=0;

matCorr = zeros(nSample*(nSample-1)/2,nPt);
k=0;
for i=1:nSample-1    
    for j=i+1:nSample        
        cvS1 = matTem(:,i);
        cvS2 = matTem(:,j);
        k = k + 1;
        for n=1:nPt
            iPos = ceil(nPeak*n/nPt);
            cvS11 = cvS1(1:iPos);
            cvS22 = cvS2(1:iPos);
            cvKeep = ones(iPos,1);
            cvKeep(cvS11==0 | cvS22==0) = 0;
            cvS11(cvKeep==0) = [];
            cvS22(cvKeep==0) = [];
            if ~isempty(cvS11)
                matCorr(k,n) = corr(cvS11,cvS22);
            end
        end
    end
end
end