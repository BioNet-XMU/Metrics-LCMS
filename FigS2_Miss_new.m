
%
% X-axes represents calibrated abandance, Y-axes represents the compound
% numers in a corrsponding interval of calibrated abandancs, e.g., [0, 0.2]
%

clear
clc

load('new_Data.mat');
load('OffSet.mat');

[cvMiss1,cvMedian1] = subGetCV(matData1);
[cvMiss2,cvMedian2] = subGetCV(matData2);
[cvMiss3,cvMedian3] = subGetCV(matData3);
[cvMiss4,cvMedian4] = subGetCV(matData4);

% Calibrate the median data for all four datasets.
cvX1 = log10(cvMedian1) - dbOffSet1;   % the number 3.9786 is the mean of Gaussian fitting curve of 6545P, which is set to zero
cvX2 = log10(cvMedian2) - dbOffSet2;   % the number 5.6322 is the mean of Gaussian fitting curve of 6545C, which is set to zero
cvX3 = log10(cvMedian3) - dbOffSet3;   % the number 3.2972 is the mean of Gaussian fitting curve of 6520P, which is set to zero
cvX4 = log10(cvMedian4) - dbOffSet4;   % the number 4.1715 is the mean of Gaussian fitting curve of 6520C, which is set to zero

nBin = 100;
cvAxis = linspace(-4.5,4.5,nBin+1);
cvAX = 0.5*(cvAxis(2:end)+cvAxis(1:end-1));


cvNumTota1 = zeros(nBin,1);
cvNumMiss1 = zeros(nBin,1);
cvNumTota2 = zeros(nBin,1);
cvNumMiss2 = zeros(nBin,1);
cvNumTota3 = zeros(nBin,1);
cvNumMiss3 = zeros(nBin,1);
cvNumTota4 = zeros(nBin,1);
cvNumMiss4 = zeros(nBin,1);

subplot(2,2,1);
for i=1:nBin
    cvHit = (cvX1>cvAxis(i)) & (cvX1<=cvAxis(i+1));
    
    cvNumTota1(i) = sum(cvHit);
    cvTem = sign(cvMiss1);
    cvNumMiss1(i) = cvNumTota1(i)- sum(cvTem(cvHit));
    
end
plot(cvAX',cvNumTota1,'r','linewidth',2);hold on;
plot(cvAX',cvNumMiss1,'--k','linewidth',2);
legend({'Detected';'Missing Values-free'});
set(gca,'Fontsize',13,'FontName','arial','FontWeight','Bold','xlim',[-4.5,4.5]);
title('6545P');
xlabel('Normalized lg(abundance)');ylabel('Compound Number');


subplot(2,2,2);
for i=1:nBin
    cvHit = (cvX2>cvAxis(i)) & (cvX2<=cvAxis(i+1));
%   cvNumTota2(i) = sum(cvHit)*50;
%   cvNumMiss2(i) = cvNumTota2(i)- sum(cvMiss2(cvHit));    
    
    cvNumTota2(i) = sum(cvHit);
    cvTem = sign(cvMiss2);
    cvNumMiss2(i) = cvNumTota2(i)- sum(cvTem(cvHit));
    
end
plot(cvAX',cvNumTota2,'g','linewidth',2);hold on;
plot(cvAX',cvNumMiss2,'--k','linewidth',2);
legend({'Detected';'Missing Values-free'});
set(gca,'Fontsize',13,'FontName','arial','FontWeight','Bold','xlim',[-4.5,4.5]);
title('6545C');
xlabel('Normalized lg(abundance)');ylabel('Compound Number');


subplot(2,2,3);
for i=1:nBin
    cvHit = (cvX3>cvAxis(i)) & (cvX3<=cvAxis(i+1));
%     cvNumTota3(i) = sum(cvHit)*50;
%     cvNumMiss3(i) = cvNumTota3(i)- sum(cvMiss3(cvHit));
    
    cvNumTota3(i) = sum(cvHit);
    cvTem = sign(cvMiss3);
    cvNumMiss3(i) = cvNumTota3(i)- sum(cvTem(cvHit));    
end
plot(cvAX',cvNumTota3,'b','linewidth',2);hold on;
plot(cvAX',cvNumMiss3,'--r','linewidth',2);
legend({'Detected';'Missing Values-free'});
set(gca,'Fontsize',13,'FontName','arial','FontWeight','Bold','xlim',[-4.5,4.5]);
title('6520P');
xlabel('Normalized lg(abundance)');ylabel('Compound Number');


subplot(2,2,4);
for i=1:nBin
    cvHit = (cvX4>cvAxis(i)) & (cvX4<=cvAxis(i+1));
%     cvNumTota4(i) = sum(cvHit)*50;
%     cvNumMiss4(i) = cvNumTota4(i)- sum(cvMiss4(cvHit));

    cvNumTota4(i) = sum(cvHit);
    cvTem = sign(cvMiss4);
    cvNumMiss4(i) = cvNumTota4(i)- sum(cvTem(cvHit));
    
end
plot(cvAX',cvNumTota4,'k','linewidth',2);hold on;
plot(cvAX',cvNumMiss4,'--r','linewidth',2);
legend({'Detected';'Missing Values-free'});
set(gca,'Fontsize',13,'FontName','arial','FontWeight','Bold','xlim',[-4.5,4.5]);
title('6520C');
xlabel('Normalized lg(abundance)');ylabel('Compound Number');
ylim([0 45]);

set(gcf,'position',[200,200,1400,800]);



function [cvMiss,cvMedian] = subGetCV(matData)
nPeak = size(matData,1);
cvMedian= zeros(nPeak,1);
for i=1:nPeak
    rvTem = matData(i,:);
    rvTem(rvTem<1) = [];
    cvMedian(i) = median(rvTem);
end
cvHit = matData<1;
cvMiss = sum(cvHit,2);
clear cvHit;
end