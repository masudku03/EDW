%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
clc, clear
PList = [4 5 6 9 10 14 28 30];
paramsAll = csvread('fitting.csv',1,1);%estimated parameters
Markers = {'+','o','*','x','d','s','>','<'};
ipt = 2; ResumeLevel_ = [0.8 1 1.2];
TITLE = ['A' 'B' 'C' 'D'];
    params = paramsAll(ipt,:);
    
    fname = sprintf('csvData\\p%d.csv',PList(ipt));%data
    Data = csvread(fname);
    time = Data(1,:); LDH = Data(2,:);

    tspan = 0:1:4*365;
    S0r = 0.99; S0 = LDH(1)*S0r;  R0 = LDH(1)-S0;

for jj = 1:numel(ResumeLevel_)
%     ipt = Pindex(jj);
    %%Adaptive therapy
    ResumeLevel = ResumeLevel_(jj); PauseLevel_ = 0.5:0.01:ResumeLevel-0.1; Dose_ = 0:0.01:1; Tmax = tspan(end);
    TTP = zeros(numel(PauseLevel_),numel(Dose_));
    for iP = 1:1:numel(PauseLevel_)
        PauseLevel = PauseLevel_(iP)
        for iD = 1:1:numel(Dose_)
            Dose = Dose_(iD)
            [t,y,treatChange] = AdaptiveTherapy(PauseLevel,ResumeLevel,Dose,params,S0,R0,tspan);
            Y = sum(y');
            %Find the TTP
            if any(find(Y(51:end)>(ResumeLevel+0.01)*Y(1)))%fix the level according to ResumeLevel
                TTP(iP,iD) = t(50+find(Y(51:end)>(ResumeLevel+0.01)*Y(1),1));
            else
                TTP(iP,iD)  = Tmax;
            end
        end
    end

    [meshP,meshD] = meshgrid(PauseLevel_,Dose_);
    figure(3)
    subplot(1,3,jj)
    surf(meshP,meshD,(TTP'),'EdgeColor','none'); hold on
    xlabel('PauseLevel');ylabel('normalized dose'); zlabel('TG'); subtitle(['K_t = ',num2str(ResumeLevel),'K_0']); title(TITLE(jj));
end
%
% print('Sfig05','-dpdf','-r300');
