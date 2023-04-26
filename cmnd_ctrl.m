% To generate the following figures.
% OptDose_ipt2.fig, OptDose_ipt6.fig, OptDose_ipt7.fig, OptDose_ipt8.fig and control.fig.
% Please check the value of M with SR_mode.
clear, clc 
T = 4*365;
nc = 1; %number of controls#######
M = T*2; %number of grid
ef = 1;
%%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%
PList = [4 5 6 9 10 14 28 30];
paramsAll = csvread('fitting.csv',1,1);%retrive the estimated parameters

B = [0  500 0 0 0 2000 568 1000]; mult = [0 2 1.5 7 6 2 1.1 50];%sets minimum and maximum values of B
level = 1;
Pindex = [2 6 7 8]; 
for jj = 1:numel(Pindex)% Loop for each patient
    ipt = Pindex(jj);
    params = paramsAll(ipt,:);
    
    fname = sprintf('csvData\\p%d.csv',PList(ipt));%read the patient data
    Data = csvread(fname);
    time = Data(1,:); LDH = Data(2,:);

    B2Interval = linspace(B(ipt),mult(ipt)*B(ipt),10); % we did simulation for linspace(B(ipt),mult(ipt)*B(ipt),100) in the manuscript
    SR_mode = zeros(size(B2Interval));
    S0r = 0.99; S0 = LDH(1)*S0r;  R0 = LDH(1)-S0; 
    ix = [S0 (1-S0r)*S0/S0r]; % initial condition
    options = odeset('NonNegative',1);   
    [t,x] = ode45(@(t,y) model(t,y,params),[0 T],[S0;R0],options); 
        [X,Y] = meshgrid(B2Interval,linspace(0,T,M+1));
        U = zeros(size(X)); a = zeros(size(B2Interval));
    for indexB = 1:numel(B2Interval)
            B1 = B2Interval(indexB) 
            K0 = 0;
            % secFBSM executes the Adaptive Forward Backward Sweep Method
            [tc xc u ld a(indexB)] = secFBSM(ix,T,M,nc,K0,B1,ef,params,2,5,level.*LDH(1));% 2 and 5 was chosen by trial and error to get a suitable starting point for initiation of secant method
            U(:,indexB) = u';
            SR_mode(indexB) = xc(1,2*365)+xc(2,2*365);%Maximum level after one year. It shoud be adjusted with M
    end

figure(ipt)% OptDose_ipt*.fig
    subplot(1,3,1)
    surface(X,Y,U,'EdgeColor','none'); xlabel('B'); ylabel('Days');zlabel('u^*'); alpha 0.5; box on; grid on; hold on; title('A');
    plot3(B2Interval(find(SR_mode>level.*LDH(1),1)-1).*ones(size(tc)),tc,U(:,find(SR_mode>level.*LDH(1),1)-1),'-','LineWidth',3,'Color',[0, 0.4470, 0.7410])
    text(B2Interval(find(SR_mode>level.*LDH(1),1)-1),SR_mode(find(SR_mode>level.*LDH(1),1)-1),'LDH(0)');

    B1 = B2Interval(find(SR_mode>level.*LDH(1),1)-1);% find the value of B that holds the tumor at the tolerable tumor volume (TTV)
    [t,x] = ode45(@(t,y) model(t,y,params),[0 T],[S0;R0],options);%ode45('state',[0 T],ix);
    subplot(1,3,2), plot(t,x(:,1)+x(:,2),'-','LineWidth',2,'DisplayName','S+R_{MTD}','Color',[0, 0, 0]);hold on; title('B'); ylabel('Tumor Volume under MTD');
    subplot(1,3,3), plot(t,x(:,2),'-','LineWidth',2,'DisplayName','R_{MTD}','Color',[0, 0, 0]);hold on; title('C'); xlim([0 T]); ylabel('R-cell under MTD');

    [tc xc u ld] = fbsm(ix,T,M,nc,K0,B1,ef,params,a(find(SR_mode>level.*LDH(1),1)-1));%make change according to the objective function#######
    
    subplot(1,3,2)
    yyaxis right; ylabel('Tumor Volume under OT'); plot(tc,xc(2,:)+xc(1,:),'-','LineWidth',2,'DisplayName',['S+R_{OT}; B=',num2str(B1)],'Color',[0, 0.4470, 0.7410])
    legend('-DynamicLegend'); xlabel('Days'); hold on; ylabel('Total Number of Cells');
    
    subplot(1,3,3)
    yyaxis right; ylabel('R-cell under OT'); plot(tc,xc(2,:),'-','LineWidth',2,'DisplayName',['R_{OT}; B=',num2str(B1)],'Color',[0, 0.4470, 0.7410])
    legend('-DynamicLegend');   xlabel('Days'); hold on; ylabel('Number of R-cells'); xlim([0 T]);

figure(111)%control.fig
        [tc xc u ld] = fbsm(ix,T,M,nc,K0,B1,ef,params,a(find(SR_mode>level.*LDH(1),1)-1));%make change according to the objective function#######
        plot(tc,u(1,:),'-','LineWidth',2,'DisplayName',['Patient ',num2str(ipt)])
        legend('-DynamicLegend'); xlabel('Days'); hold on; ylabel('u^*');
end

% f = gcf;
% exportgraphics(f,'OptDose_ipt2.pdf','Resolution',300)