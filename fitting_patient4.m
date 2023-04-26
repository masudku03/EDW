%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
clc; clear
PList = [4 5 6 9 10 14 28 30];
jj = 4;

LDH = [331;185;200;164;213]; time = [0,35,63,87,138];
x0fcn = @(params) LDH(1).*[0.99; 0.01];
yfcn = @(x,params) (x(:,1)+x(:,2)); 

params = [0.3059  460.6937    0.1865    2.0000];
paramnames = {'r','K','\delta','c'}; 

%Parameter Estimation ML
[paramestsML, fval] = fminsearch(@(p) fittingCost(time,p,LDH,x0fcn,yfcn),params,optimset('Display','iter','MaxFunEvals',5000,'MaxIter',5000))

%%Re-simulate the model with the final parameter estimates
[test,xest] = ode45(@model,1:1:time(end),x0fcn(paramestsML),[],paramestsML);
yest = yfcn(xest,paramestsML);
figure(1)
% Plot results
subplot(2,4,jj)
    hold on
    Data = csvread(sprintf('csvData\\p%d.csv',PList(jj)));
    timeOld = Data(1,:); LDHOld = Data(2,:);
    plot(timeOld,LDHOld,'ko','LineWidth',1); hold on
    plot(test,yest(:,1),'-','LineWidth',2);
    legend('Data','Model ','Location','nw'); 
    ylabel('LDH');  title(['Patient ',num2str(jj)]);
    xlabel('Days'); box on

% Profile Likelihoods ML

profiles = [];
costfun = @(p) fittingCost(time,p,LDH,x0fcn,yfcn);
threshold = chi2inv(0.9,length(paramestsML))/2 + fval;
profrange = 0.2; %percent range for profile to run across
figure(2)
for i=1:length(paramestsML)
    profiles(:,:,i) = ProfLike(paramestsML,i,costfun,profrange);

    subplot(4,4,8+i)
    hold on
    plot(profiles(:,1,i),profiles(:,2,i),'LineWidth',2)
    plot(paramestsML(i),fval,'r*','LineWidth',2)
    xlabel(paramnames{i})
    ylabel(['PL_',paramnames{i}])
    box on
end
% Numerically approximate the FIM
FIM = MiniFisher(time,paramestsML,x0fcn,@model,yfcn);
%Calculate & print rank of FIM
rank(FIM)
figure(1)
text(60,300,['Rank(FIM) =',num2str(rank(FIM))]);
