clear;
clc

matData1 = xlsread('D:\Research\投稿材料\202001-Daniel\MatlabCode\New Data\N6545P');
matData2 = xlsread('D:\Research\投稿材料\202001-Daniel\MatlabCode\New Data\N6545C');
matData3 = xlsread('D:\Research\投稿材料\202001-Daniel\MatlabCode\New Data\N6520P');
matData4 = xlsread('D:\Research\投稿材料\202001-Daniel\MatlabCode\New Data\N6520C');

save('new_Data.mat');

nBin = 100;

cvX1 = matData1(:);
cvX2 = matData2(:);
cvX3 = matData3(:);
cvX4 = matData4(:);

cvX1(cvX1<1)= [];
cvX2(cvX2<1)= [];
cvX3(cvX3<1)= [];
cvX4(cvX4<1)= [];

cvX1 = log10(cvX1);
cvX2 = log10(cvX2)-0.6;
cvX3 = log10(cvX3);
cvX4 = log10(cvX4);

subplot(2,2,1);
h1 = histfit(cvX1,nBin,'gamma');
[~,iPos]=max(h1(2).YData);
dbZeroPos1 = h1(2).XData(iPos(1));
xlabel('lg(Abundance)');
ylabel('Compound number');
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[0,9.5]);
[~,iPos]=max(h1(2).YData);
dbMu = h1(2).XData(iPos(1));

pd = fitdist(cvX1,'gamma');
y  = pdf(pd,h1(1).XData);
y  = max(h1(2).YData)*y/max(y);
[~,iPos] = max(y);
dbOffSet1 = h1(1).XData(iPos);
dbArea = sum(min([h1(1).YData;y]))/sum(y);
title(sprintf('Overlap=%3.1f%%; mean=%3.2f, std=%3.2f,alpha=%3.2f,beta=%3.2f',100*dbArea,dbMu,pd.a*pd.b*pd.b,pd.a,1.0/pd.b));
h1(1).FaceColor = [1 0 0];
h1(1).EdgeColor = [1 0 0];
h1(2).Color = [0 0 1];
h1(2).LineStyle = '--';


%------------------------------------------------------------------------
subplot(2,2,2);
h2 = histfit(cvX2,nBin,'gamma');
[~,iPos]=max(h2(2).YData);
dbZeroPos2 = h2(2).XData(iPos(1));
xlabel('lg(Abundance)');
ylabel('Compound number');
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[0,9.5]);
[~,iPos]=max(h2(2).YData);
dbMu = h2(2).XData(iPos(1));

pd = fitdist(cvX2,'gamma');
y  = pdf(pd,h2(1).XData);
y  = max(h2(2).YData)*y/max(y);
[~,iPos] = max(y);
dbOffSet2 = h2(1).XData(iPos);
dbArea = sum(min([h2(1).YData;y]))/sum(y);
title(sprintf('Overlap=%3.1f%%; mean=%3.2f, std=%3.2f,alpha=%3.2f,beta=%3.2f',100*dbArea,dbMu,pd.a*pd.b*pd.b,pd.a,1.0/pd.b));
h2(1).FaceColor = [0 1 0];
h2(1).EdgeColor = [0 1 0];
h2(2).Color = [1 0 0];
h2(2).LineStyle = '--';


%------------------------------------------------------------------------
subplot(2,2,3);
h3 = histfit(cvX3,nBin,'gamma');
[~,iPos]=max(h3(2).YData);
dbZeroPos3 = h3(2).XData(iPos(1));
xlabel('lg(Abundance)');
ylabel('Compound number');
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[0,9.5]);
[~,iPos]=max(h3(2).YData);
dbMu = h3(2).XData(iPos(1));

pd = fitdist(cvX3,'gamma');
y  = pdf(pd,h3(1).XData);
y  = max(h3(2).YData)*y/max(y);
[~,iPos] = max(y);
dbOffSet3 = h3(1).XData(iPos);
dbArea = sum(min([h3(1).YData;y]))/sum(y);
title(sprintf('Overlap=%3.1f%%; mean=%3.2f, std=%3.2f,alpha=%3.2f,beta=%3.2f',100*dbArea,dbMu,pd.a*pd.b*pd.b,pd.a,1.0/pd.b));
h3(1).FaceColor = [0 0 1];
h3(1).EdgeColor = [0 0 1];
h3(2).Color = [1 0 0];
h3(2).LineStyle = '--';

%------------------------------------------------------------------------
subplot(2,2,4);
h4 = histfit(cvX4,nBin,'gamma');
[~,iPos]=max(h4(2).YData);
dbZeroPos4 = h4(2).XData(iPos(1));
xlabel('lg(Abundance)');
ylabel('Compound number');
set(gca,'Fontsize',9,'FontName','arial','FontWeight','Bold','xlim',[0,9.5]);
[~,iPos]=max(h4(2).YData);
dbMu = h4(2).XData(iPos(1));

pd = fitdist(cvX4,'gamma');
y  = pdf(pd,h4(1).XData);
y  = max(h4(2).YData)*y/max(y);
[~,iPos] = max(y);
dbOffSet4 = h4(1).XData(iPos);
dbArea = sum(min([h4(1).YData;y]))/sum(y);
title(sprintf('Overlap=%3.1f%%; mean=%3.2f, std=%3.2f,alpha=%3.2f,beta=%3.2f',100*dbArea,dbMu,pd.a*pd.b*pd.b,pd.a,1.0/pd.b));
h4(1).FaceColor = [0 0 0];
h4(1).EdgeColor = [0 0 0];
h4(2).Color = [1 0 0];
h4(2).LineStyle = '--';

set(gcf,'position',[100,100,1000,800]);