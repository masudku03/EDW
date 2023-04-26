%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
clc,clear
PList = [4 5 6 9 10 14 28 30];
params = csvread('fitting.csv',1,1);%estimated parameters
for ipt = 1:numel(PList)
    fname = sprintf('csvData\\p%d.csv',PList(ipt));
    Data = csvread(fname);%data
    LDH0(ipt) = Data(2,1);
end
EDW_Normalized = [params(:,1).*(1-LDH0'./params(:,2))./params(:,3), params(:,1).*(1-1./params(:,4))./params(:,3)];
% %%
% EDW_Normalized = [0.696335394	0.696335394;
% 0.565634668	0.834748097;
% 0.718420989	0.887008481;
% 0.396526615	0.974508418;
% 0.450886322	0.481321519;
% 0.200983482	0.904691942;
% 0.810410642	0.821976678;
% 0.010241161	0.723921554];
OT_D = [0.56689 0.201132 0.810641 0.0103735];
AT_DW = [0.57 0.84; 0.22 1; 0.815 0.82; 0.02 0.73]; %from AT_allPatient.fig
Pindex = [2 6 7 8];
figure
for jj = 1:numel(Pindex)
    subplot(1,2,1)
    ipt = Pindex(jj);
    plot(EDW_Normalized(ipt,:),[jj+0.2 jj+0.2],'bo--','LineWidth',1); hold on
    plot(AT_DW(jj,:),[jj jj],'kd','MarkerSize',8,'LineWidth',1); 
    plot(OT_D(jj),jj-0.2,'*','MarkerSize',10,'LineWidth',1,'MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
end
yticks(1:8);yticklabels({['Patient ',num2str(2)],['Patient ',num2str(6)],['Patient ',num2str(7)],['Patient ',num2str(8)]});
ylim([0.5 5]); xlabel('Dose');

    subplot(1,2,2)
    jj = 3;
    ipt = Pindex(jj);
    plot(EDW_Normalized(ipt,:),[jj+0.2 jj+0.2],'bo--','LineWidth',1); hold on
    plot(AT_DW(jj,:),[jj jj],'kd:','MarkerSize',8,'LineWidth',1); 
    plot(OT_D(jj),jj-0.2,'*','MarkerSize',10,'LineWidth',1,'MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
