clear

load('new_Data.mat');
load('OffSet.mat');

nSample = size(matData1,2);


[cvInd1,cvMedian1] = subGetCV(matData1);
[cvInd2,cvMedian2] = subGetCV(matData2);
[cvInd3,cvMedian3] = subGetCV(matData3);
[cvInd4,cvMedian4] = subGetCV(matData4);

cvX1 = log10(cvMedian1)-dbOffSet1;
cvX2 = log10(cvMedian2)-dbOffSet2;
cvX3 = log10(cvMedian3)-dbOffSet3;
cvX4 = log10(cvMedian4)-dbOffSet4;
dbMax = max([cvX1;cvX2;cvX3;cvX4]);
dbMin = min([cvX1;cvX2;cvX3;cvX4]);

nPt=20;
[cvICC1,x1] = MyICC(log10(matData1(cvInd1,:)),cvX1(cvInd1),nPt );
[cvICC2,x2] = MyICC(log10(matData2(cvInd2,:)),cvX2(cvInd2),nPt );
[cvICC3,x3] = MyICC(log10(matData3(cvInd3,:)),cvX3(cvInd3),nPt );
[cvICC4,x4] = MyICC(log10(matData4(cvInd4,:)),cvX4(cvInd4),nPt );

plot(x1,cvICC1,'r','LineWidth',2); hold on
plot(x2,cvICC2,'g','LineWidth',2);
plot(x3,cvICC3,'b','LineWidth',2);
plot(x4,cvICC4,'k','LineWidth',2);
plot([0,0],[0.15,1.05],'--r','LineWidth',1);
xlabel('Normalized lg(Abundance)');

hold off
legend(' 6545P',' 6545C',' 6520P',' 6520C');
ylabel('ICC');
set(gca,'Fontsize',14,'FontName','Arial','FontWeight','Bold','ylim',[0.15,1.02],'xlim',[-4.5,4.5]);
set(gcf,'position',[200,200,800,600]);

cvICC1(10)
cvICC2(10)
cvICC3(10)
cvICC4(10)



function [cvInd,cvMedian] = subGetCV(matData)
nPeak = size(matData,1);
cvMedian= zeros(nPeak,1);
for i=1:nPeak
    rvTem = matData(i,:);
    rvTem(rvTem<1) = [];
    cvMedian(i) = median(rvTem);
end
[~,cvInd] = sort(cvMedian,'ascend');
end