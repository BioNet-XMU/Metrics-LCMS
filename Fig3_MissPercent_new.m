clear;
clc;

load('new_Data.mat');

nSample = size(matData1,2);

cvHit1 = matData1<1;
cvHit2 = matData2<1;
cvHit3 = matData3<1;
cvHit4 = matData4<1;

cvMiss1 = sum(cvHit1,2);
cvMiss2 = sum(cvHit2,2);
cvMiss3 = sum(cvHit3,2);
cvMiss4 = sum(cvHit4,2);

cvMP1 = zeros(nSample,1);
cvMP2 = zeros(nSample,1);
cvMP3 = zeros(nSample,1);
cvMP4 = zeros(nSample,1);

for i= 1:nSample
    cvMP1(i) = sum(cvMiss1<i);
    cvMP2(i) = sum(cvMiss2<i);
    cvMP3(i) = sum(cvMiss3<i);
    cvMP4(i) = sum(cvMiss4<i);
end
% cvMP1 = flipud(cvMP1);
% cvMP2 = flipud(cvMP2);
% cvMP3 = flipud(cvMP3);
% cvMP4 = flipud(cvMP4);

x=(nSample:-1:1)*100/nSample;
line([80,80],[75,102],'color','r','linestyle','--');hold on;
h1=plot(x,100*cvMP1/size(cvMiss1,1),'-r','linewidth',2);hold on;
h2=plot(x,100*cvMP2/size(cvMiss2,1),'-g','linewidth',2);
h3=plot(x,100*cvMP3/size(cvMiss3,1),'-b','linewidth',2);
h4=plot(x,100*cvMP4/size(cvMiss4,1),'-k','linewidth',2);

AUC1=mean(cvMP1/size(cvMiss1,1));
AUC2=mean(cvMP2/size(cvMiss2,1));
AUC3=mean(cvMP3/size(cvMiss3,1));
AUC4=mean(cvMP4/size(cvMiss4,1));

set(gca,'xtick',[0,20,40,60,80,100],'xticklabel',{'100','80','60','40','20','0'},'XTickMode','manual');
set(gca,'Fontsize',14,'FontName','arial','FontWeight','Bold','ylim',[98.5,100.1]);%,'xlim',[1,51]);
legend([h1,h2,h3,h4],sprintf('6545P, AUC=%4.3f',AUC1),sprintf('6545C, AUC=%4.3f',AUC2),sprintf('6520P, AUC=%4.3f',AUC3),sprintf('6520C, AUC=%4.3f',AUC4));
ylabel('Percentage of Compounds (%)');
xlabel('Percentage of missing values (%)');
box on;
set(gcf,'position',[200,200,800,600]);

return
