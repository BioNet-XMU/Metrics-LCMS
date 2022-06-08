clear
clc

load('s.mat');
load('new_Data.mat');
load('OffSet.mat');

nSample = size(matData1,2);

[cvCV1,cvMedian1] = subGetCV(matData1);
[cvCV2,cvMedian2] = subGetCV(matData2);
[cvCV3,cvMedian3] = subGetCV(matData3);
[cvCV4,cvMedian4] = subGetCV(matData4);

cvX1 = log10(cvMedian1)-dbOffSet1;
cvX2 = log10(cvMedian2)-dbOffSet2;
cvX3 = log10(cvMedian3)-dbOffSet3;
cvX4 = log10(cvMedian4)-dbOffSet4;
dbMax = max([cvX1;cvX2;cvX3;cvX4]);
dbMin = min([cvX1;cvX2;cvX3;cvX4]);

cvX1(cvCV1>1)=[];
cvX2(cvCV2>1)=[];
cvX3(cvCV3>1)=[];
cvX4(cvCV4>1)=[];

cvY1 = cvCV1(cvCV1<=1);
cvY2 = cvCV2(cvCV2<=1);
cvY3 = cvCV3(cvCV3<=1);
cvY4 = cvCV4(cvCV4<=1);

nBin = 52;
newJet=jet(256);
newJet(1,:)=[1,1,1];

cvX1 = [dbMin-0.2;cvX1;dbMax+0.2];
cvX2 = [dbMin-0.2;cvX2;dbMax+0.2];
cvX3 = [dbMin-0.2;cvX3;dbMax+0.2];
cvX4 = [dbMin-0.2;cvX4;dbMax+0.2];
cvY1 = [0;cvY1;1];
cvY2 = [0;cvY2;1];
cvY3 = [0;cvY3;1];
cvY4 = [0;cvY4;1];

i = (linspace(dbMin-0.2,dbMax+0.2,nBin+1))';
j = ones(nBin+1,1)*0.25;

j1=hist3([cvX1,cvY1],[53,53]);
j2=hist3([cvX2,cvY2],[53,53]);
j3=hist3([cvX3,cvY3],[53,53]);
j4=hist3([cvX4,cvY4],[53,53]);
s1=j1(:,ceil(0.25*53));
s2=j2(:,ceil(0.25*53));
s3=j3(:,ceil(0.25*53));
s4=j4(:,ceil(0.25*53));
nMax=max([max(j1(:)),max(j2(:)),max(j1(:)),max(j1(:))])+5;
n1=sum(j1(:));
n2=sum(j2(:));
n3=sum(j3(:));
n4=sum(j4(:));

subplot(2,2,1);
hist3([cvX1,cvY1],[53,53]);hold on;
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax*n1/n1],'xlim',[dbMin,dbMax]);
set(gca,'ztick',[0.5,1.0,1.5,2.0,2.5]*n1/100,'zticklabel',{'0.5','1.0','1.5','2.0','2.5'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold');
colormap(newJet)
caxis([0,nMax]);
ylabel('Coefficient of Variation');
xlabel('Normalized log10(Abundance)');
zlabel('Percentage of compounds (%)');
plot3(i,j,s1+0.5,'-r','linewidth',1.5);
view([-140 43]);
title('6545P');

subplot(2,2,2);
hist3([cvX2,cvY2],[53,53]);hold on;
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax*n2/n1],'xlim',[dbMin,dbMax]);
set(gca,'ztick',[0.5,1.0,1.5,2.0,2.5]*n2/100,'zticklabel',{'0.5','1.0','1.5','2.0','2.5'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold');
colormap(newJet)
caxis([0,nMax*2222/5208]);
ylabel('Coefficient of Variation');
xlabel('Normalized log10(Abundance)');
zlabel('Percentage of compounds (%)');
plot3(i,j,s2+0.5,'-r','linewidth',1.5);
view([-140 43]);
title('6545C');

subplot(2,2,3);
hist3([cvX3,cvY3],[53,53]);hold on;
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax*n3/n1],'xlim',[dbMin,dbMax]);
set(gca,'ztick',[0.5,1.0,1.5,2.0,2.5]*n3/100,'zticklabel',{'0.5','1.0','1.5','2.0','2.5'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold');
colormap(newJet)
caxis([0,nMax*1843/5208]);
ylabel('Coefficient of Variation');
xlabel('Normalized log10(Abundance)');
zlabel('Percentage of compounds (%)');
plot3(i,j,s3+0.5,'-r','linewidth',1.5);
view([-140 43]);
title('6520P');

subplot(2,2,4);
hist3([cvX4,cvY4],[53,53]);hold on;
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax*n4/n1],'xlim',[dbMin,dbMax]);
set(gca,'ztick',[0.5,1.0,1.5,2.0,2.5]*n4/100,'zticklabel',{'0.5','1.0','1.5','2.0','2.5'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold');
colormap(newJet)
caxis([0,nMax*1223/5208]);
ylabel('Coefficient of Variation');
xlabel('Normalized log10(Abundance)');
zlabel('Percentage of compounds (%)');
plot3(i,j,s4+0.5,'-r','linewidth',1.5);
set(gcf,'position',[100,100,1000,800]);
view([-140 43]);
title('6520C');


function [cvCV,cvMedian] = subGetCV(matData)
nPeak = size(matData,1);
cvCV = zeros(nPeak,1);
cvMedian= zeros(nPeak,1);
for i=1:nPeak
    rvTem = matData(i,:);
    rvTem(rvTem<1) = [];
    cvCV(i) = std(rvTem)/mean(rvTem);
    cvMedian(i) = median(rvTem);
end
end