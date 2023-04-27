%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
clc, clear
PList = [4 5 6 9 10 14 28 30];%Patient List
paramsAll = csvread('fitting.csv',1,1);%read estimated parameters
Pindex = [2 6 7 8];% index from the Patient List
TITLE = ['A' 'B' 'C' 'D']; %figure titles

for jj = 1:numel(Pindex) % This loop executes for each patient  
    ipt = Pindex(jj); % select patient
    params = paramsAll(ipt,:); % read the respective parameters
    fname = sprintf('csvData\\p%d.csv',PList(ipt));%read the respective data
    Data = csvread(fname);
    time = Data(1,:); LDH = Data(2,:);

    tspan = 0:1:4*365;%mention time grid
    S0r = 0.99; S0 = LDH(1)*S0r;  R0 = LDH(1)-S0;%set initial condition

    %%Adaptive therapy  **************************************************
    PauseLevel_ = 0.5:0.1:0.9; %To produce AT_allPatient.fig we used  0.5:0.01:0.9
    ResumeLevel = 0.999; 
    Dose_ = 0:0.1:1; %To produce AT_allPatient.fig we used  0:0.01:1
    %%%%%%%%%%%%%%%%%  ***************************************************
    Tmax = tspan(end);
    TTP = zeros(numel(PauseLevel_),numel(Dose_));
    for iP = 1:1:numel(PauseLevel_)
        PauseLevel = PauseLevel_(iP)
        for iD = 1:1:numel(Dose_)
            Dose = Dose_(iD)
            [t,y,treatChange] = AdaptiveTherapy(PauseLevel,ResumeLevel,Dose,params,S0,R0,tspan); %simulate adaptivce therapy
            Y = sum(y');
            
%             figure(ipt)
%             % for AT_PAtient5.fig fix j=1, use the following 6 lines once with Dose, and then with PauseLevel
% %             if (sum([0.5,0.7,0.9]-Dose==0) && (PauseLevel == 0.5))%Dose
%             if (sum([0.6,0.65,0.7]-PauseLevel==0) && (Dose == 0.9))%PauseLevel
% %                 subplot(1,2,1)%Dose
% %                 plot(t,Y,'linewidth',2,'DisplayName',['S(t)+R(t) for Dose = ', num2str(Dose)]); hold on; title('A'); subtitle(['PauseLevel ',num2str(PauseLevel)]);%Dose
%                 subplot(1,2,2)%PauseLevel
%                 plot(t,Y,'linewidth',2,'DisplayName',['S(t)+R(t) for PauseLevel = ', num2str(PauseLevel)]); hold on; title('B'); subtitle(['Dose ',num2str(Dose)]);%PauseLevel
%                 xlabel('Days'); ylabel('Tumor Volume');
%                 legend('-DynamicLegend');
%             end
            %Find the TTP
            if any(find(Y>Y(1)))%fix the level according to ResumeLevel
                TTP(iP,iD) = t(find(Y>Y(1),1)); 
            else
                TTP(iP,iD)  = Tmax;
            end
        end
    end

    [meshP,meshD] = meshgrid(PauseLevel_,Dose_);
    figure(3)
    subplot(2,2,jj)
    surf(meshP,meshD,(TTP'),'EdgeColor','none'); hold on
    xlabel('PauseLevel');ylabel('Dose'); zlabel('TG'); subtitle(['Patient ',num2str(ipt)]); title('A');
end
%%
% print('fig07','-dpdf','-r300');
