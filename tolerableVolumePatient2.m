% To generate the figure EDW_Kt_patient2.fig
clc,clear
PList = [4 5 6 9 10 14 28 30];
params = csvread('fitting.csv',1,1);%estimated parameters
for ipt = 1:numel(PList)
    fname = sprintf('csvData\\p%d.csv',PList(ipt));
    Data = csvread(fname);%data
    LDH0(ipt) = Data(2,1);
end
ipt = 2;
Kt1 = LDH0(ipt).*[0.7, params(ipt,2)/(params(ipt,4)*LDH0(ipt)), 0.8, 0.9, 1, 1.1, 1.201];
Kt2 = LDH0(ipt).*[params(ipt,2)/(params(ipt,4)*LDH0(ipt)), 0.8, 0.9, 1, 1.1, 1.2];
AT_DW = [0.75 0.83; 0.56 0.83; 0.38 0.83]; %from AT_Patient2.m


EDW_Normalized(:,1) = params(ipt,1).*(1-Kt1'./params(ipt,2))./params(ipt,3);
EDW_Normalized(:,2) = params(ipt,1)*(1-1./params(ipt,4))./params(ipt,3);
OT_D = [0.754038937237185, 0.658184019072253, 0.566903023725922, 0.476473139285611, 0.383534391360251]; % to be inherited from cmnd_ctrlPatient2.m

area(Kt2,EDW_Normalized(2:end,2),'FaceColor',[0.9 0.9 0.9],'DisplayName','EDW'); hold on;
area(Kt1,EDW_Normalized(:,1),'FaceColor',[1 1 1],'HandleVisibility','off');
plot(Kt1(3:end),OT_D,'*','MarkerSize',10,'LineWidth',1,'MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'DisplayName','optimal dose'); 
plot(LDH0(ipt).*[0.8 0.8],AT_DW(1,:),'Color',[0 0.4470 0.7410],'DisplayName','EDW_{AT}','LineWidth',3);
plot(LDH0(ipt).*[1 1],AT_DW(2,:),'Color',[0 0.4470 0.7410],'HandleVisibility','off','LineWidth',3);
plot(LDH0(ipt).*[1.2 1.2],AT_DW(3,:),'Color',[0 0.4470 0.7410],'HandleVisibility','off','LineWidth',3);
xlabel('Tolerable Tumor Volume(K_{tol})'); ylabel('normalized dose'); title(['Patient ',num2str(ipt)]);
xticks(Kt1); xticklabels({[num2str(0.7),'*K_0'],[],[num2str(0.8),'*K_0'],[num2str(0.9),'*K_0'],['K_0'],[num2str(1.1),'*K_0'],[num2str(1.2),'*K_0']});
legend('-DynamicLegend');
xline(LDH0(ipt)*params(ipt,2)/(params(ipt,4)*LDH0(ipt)),'--','DisplayName','threshold K_{tol}');

% 100*params(ipt,2)/(params(ipt,4)*LDH0(ipt))
%%
% print('fig09','-dpdf','-r300');