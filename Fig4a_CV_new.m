clear

load('new_Data.mat');

nSample = size(matData1,2);

cvCV1 = subGetCV(matData1);
cvCV2 = subGetCV(matData2);
cvCV3 = subGetCV(matData3);
cvCV4 = subGetCV(matData4);

nBin = 20;

[cvX1,cvBin1] = MyCVBin(cvCV1,nBin);
[cvX2,cvBin2] = MyCVBin(cvCV2,nBin);
[cvX3,cvBin3] = MyCVBin(cvCV3,nBin);
[cvX4,cvBin4] = MyCVBin(cvCV4,nBin);

hold on;
line([0.25,0.25]',[100,0]','LineStyle','--','Color',[1,0,0]);
h1 = plot(cvX1,100*cvBin1,'-rs','linewidth',1.5);

h2 = plot(cvX2,100*cvBin2,'-g*','linewidth',1.5);
h3 = plot(cvX3,100*cvBin3,'-bp','linewidth',1.5);
h4 = plot(cvX4,100*cvBin4,'-kd','linewidth',1.5);
legend([h1,h2,h3,h4],sprintf(' 6545P, Area=%4.3f',mean(cvBin1)),sprintf(' 6545C, Area=%4.3f',mean(cvBin2)),sprintf(' 6520P, Area=%4.3f',mean(cvBin3)),sprintf(' 6520C, Area=%4.3f',mean(cvBin4)));
xlabel('Coefficient of Variation (CV)');
ylabel('Percentage of Compounds (%)');
set(gca,'Fontsize',14,'FontName','Times New Roman','FontWeight','Bold','xlim',[0,1],'ylim',[-2,103]);
set(gcf,'position',[200,200,800,600]);
box on;

cvBin1(6)
cvBin2(6)
cvBin3(6)
cvBin4(6)

function cvCV = subGetCV(matData)
nPeak = size(matData,1);
cvCV = zeros(nPeak,1);
for i=1:nPeak
    rvTem = matData(i,:);
    rvTem(rvTem<1) = [];
    cvCV(i) = std(rvTem)/mean(rvTem);
end
end