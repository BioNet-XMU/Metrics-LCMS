clear

load('new_Data.mat');
load('OffSet.mat');

nSample = size(matData1,2);

[cvCV1,cvMedian1] = subGetCV(matData1);
[cvCV2,cvMedian2] = subGetCV(matData2);
[cvCV3,cvMedian3] = subGetCV(matData3);
[cvCV4,cvMedian4] = subGetCV(matData4);

nPt=21;

newJet=jet(256);
newJet(1,:)=[1,1,1];

[cvICC1,cvX1,cvZ1] = MyICC_cv( log10(matData1),cvCV1,nPt );
[cvICC2,cvX2,cvZ2] = MyICC_cv( log10(matData2),cvCV2,nPt );
[cvICC3,cvX3,cvZ3] = MyICC_cv( log10(matData3),cvCV3,nPt );
[cvICC4,cvX4,cvZ4] = MyICC_cv( log10(matData4),cvCV4,nPt );
cvICC1=[-0.08;cvICC1];
cvICC2=[-0.08;cvICC2];
cvICC3=[-0.08;cvICC3];
cvICC4=[-0.08;cvICC4];
cvZ1 = [-0.08;cvZ1];
cvZ2 = [-0.08;cvZ2];
cvZ3 = [-0.08;cvZ3];
cvZ4 = [-0.08;cvZ4];

j1=hist3([cvICC1,cvZ1],[nPt,nPt]);
j2=hist3([cvICC2,cvZ2],[nPt,nPt]);
j3=hist3([cvICC3,cvZ3],[nPt,nPt]);
j4=hist3([cvICC4,cvZ4],[nPt,nPt]);
s1=j1(:,ceil(0.3*nPt));
s2=j2(:,ceil(0.3*nPt));
s3=j3(:,ceil(0.3*nPt));
s4=j4(:,ceil(0.3*nPt));
nMax = max([max(j1(:)),max(j2(:)),max(j3(:)),max(j4(:))])+20;
n1=sum(j1(:));
n2=sum(j2(:));
n3=sum(j3(:));
n4=sum(j4(:));

i = (linspace(0,1,nPt))';
j = ones(nPt,1)*0.26;

subplot(2,2,1);
hist3([cvICC1,cvZ1],[nPt,nPt]);hold on   % max(h1(:))=1543
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax]*n1/n1,'xlim',[0,1]);
set(gca,'ztick',[0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40,0.45,0.50]*n1,'zticklabel',{'5','10','15','20','25','30','35','40','45','50'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[-0.05,1.01],'ylim',[-0.05,1]);
colormap(newJet)
caxis([0,nMax]*n1/n1);
ylabel('CV');
xlabel('ICC');
zlabel('Percentage of Compounds (%)');
%plot3(i,j,s1+0.5,'-r','linewidth',1.5);
view([-140 43]);

subplot(2,2,2);
hist3([cvICC2,cvZ2],[nPt,nPt]);hold on  % max(h2(:))=400
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax]*n2/n1,'xlim',[0,1]);
set(gca,'ztick',[0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40]*n2,'zticklabel',{'5','10','15','20','25','30','35','40'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[-0.05,1],'ylim',[-0.05,1]);
colormap(newJet)
caxis([0,nMax]*n2/n1);
ylabel('CV');
xlabel('ICC');
zlabel('Percentage of Compounds (%)');
%plot3(i,j,s2+0.5,'-r','linewidth',1.5);
view([-140 43]);

subplot(2,2,3);
hist3([cvICC3,cvZ3],[nPt,nPt]);hold on   % max(h3(:))=351
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax]*n3/n1,'xlim',[0,1]);
set(gca,'ztick',[0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40]*n3,'zticklabel',{'5','10','15','20','25','30','35','40'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[-0.05,1],'ylim',[-0.05,1]);
colormap(newJet)
caxis([0,nMax]*n3/n1);
ylabel('CV');
xlabel('ICC');
zlabel('Percentage of Compounds (%)');
%plot3(i,j,s3+0.5,'-r','linewidth',1.5);
view([-140 43]);

subplot(2,2,4);
hist3([cvICC4,cvZ4],[nPt,nPt]);hold on  % max(h4(:))=140
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto','EdgeColor',[0.5,0.5,0.5]);
set(gca,'zlim',[0,nMax]*n4/n1,'xlim',[0,1]);
set(gca,'ztick',[0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40]*n4,'zticklabel',{'5','10','15','20','25','30','35','40'});
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[-0.05,1],'ylim',[-0.05,1]);
colormap(newJet)
caxis([0,nMax]*n4/n1);
ylabel('CV');
xlabel('ICC');
zlabel('Percentage of Compounds (%)');
%plot3(i,j,s4+0.5,'-r','linewidth',1.5);
set(gcf,'position',[100,100,1000,800]);
view([-140 43]);

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