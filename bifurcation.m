% To generate the bifurcation.fig.
% the bifurcation diagram
clc; clear

rS = 0.02; rR = 0.02; c = 3; a = 0.00; K = 1000; K0 = 500;

d = 0:0.0001:1.5*rS;
RonlyEq = K*ones(size(d));
dS = d(d<rS*(c-1)/c);
dS_U = d(d<rS); dS_U = dS_U(dS_U>rS*(c-1)/c);
SonlyEq = K*(1-dS./rS).*ones(size(dS)); SonlyEqU = K*(1-dS_U./rS).*ones(size(dS_U));
x_eq = [K*dS/(rS*(c-1));(c*K*(rS-dS)-K*rS)/(rS*(c-1))];
figure
subplot(3,3,[1:6])
yline(0,'k--','LineWidth',1.5);hold on; 
plot(d,RonlyEq,'-','LineWidth',2,'Color',[0.8500, 0.3250, 0.0980]); 
plot(dS_U,SonlyEqU,'--','LineWidth',2,'Color',[0, 0.4470, 0.7410]);
plot(dS,x_eq(2,:),'-.','LineWidth',2,'Color',[0.8500, 0.3250, 0.0980]);
plot(dS,x_eq(1,:),'-.',dS,SonlyEq,'-','LineWidth',2,'Color',[0, 0.4470, 0.7410]);
ylim([0 1.1*K]); xlabel('\delta'); ylabel('Cell Population'); box on
legend('Unstable trivial equilibrium','Stable R-only equilibrium','Unstable S-only equilibrium','R-population of unstable coexistance equilibrium','S-population of unstable coexistance equilibrium','Stable S-only equilibrium','AutoUpdate','off');
xline(rS*(c-1)/c,':','LineWidth',1.5); text(1.01*rS*(c-1)/c,500,'$\delta=\frac{r(c-1)}{c}$','Interpreter','latex','FontSize',13)
xline(rS,':','LineWidth',1.5); text(1.01*rS,300,'$\delta=r$','Interpreter','latex','FontSize',13); 
text(0.35*rS*(c-1)/c,800,'Case III','FontSize',10); text(1.1*rS*(c-1)/c,800,'Case II','FontSize',10); text(1.1*rS,800,'Case I','FontSize',10); 
d_safe = rS*(1-K0/K);
plot(0:0.0001:d_safe,K0*ones(size(0:0.0001:d_safe)),'K-','LineWidth',1)
plot([d_safe,d_safe],[0, K0],'K-','LineWidth',1);
text(0.0001,1050,'K','FontSize',10);text(0.0001,540,'K_0','FontSize',10);


% the phase plots
params = [0.02 1000 0.021 3]; 
r = params(1); K = params(2); d= params(3); c = params(4);%we need this for drawing the nullcines
T = 1000;
Step = 1; R = 0:Step:K;
SS = @(R) K*(1-d/r)-R;%S-nullcine
SR = @(R) (K-R)./c;%R-nullcine
%%Equilibrium
subplot(3,3,9)
x_eq = [K*d/(r*(c-1)) c*K*(1- d/r - 1/c)/(c-1)];
plot(R,SS(R),':','LineWidth',1,'Color',[0, 0.4470, 0.7410]); xlabel('R'); ylabel('S'); hold on
plot(R,SR(R),':','LineWidth',1,'Color',[0.8500, 0.3250, 0.0980]); xlim([0 K]); ylim([0 K]);

ix =  [800,190];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',[0.10 0.10 0.10]);%

ix =  [200,200];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',3.*[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',3.*[0.10 0.10 0.10]);%

ix =  [450,500];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',6.*[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',6.*[0.10 0.10 0.10]);%
box off;
plot([0 K],[K 0],'-k');
plot(K,0,'o','Color',[0.8500, 0.3250, 0.0980],'LineWidth',3,'MarkerSize',2);
title('D');subtitle('Case I $\left(r<\delta\right)$','FontSize',10,'Interpreter','latex'); 
%
params = [0.02 1000 0.014 3]; 
r = params(1); K = params(2); d= params(3); c = params(4);%we need this for drawing the nullcines
T = 5000;
Step = 1; R = 0:Step:K;
SS = @(R) K*(1-d/r)-R;%S-nullcine
SR = @(R) (K-R)./c;%R-nullcine


subplot(3,3,8)
x_eq = [K*d/(r*(c-1)) c*K*(1- d/r - 1/c)/(c-1)];
plot(R,SS(R),':','LineWidth',1,'Color',[0, 0.4470, 0.7410]); xlabel('R'); ylabel('S'); hold on
plot(R,SR(R),':','LineWidth',1,'Color',[0.8500, 0.3250, 0.0980]); xlim([0 K]); ylim([0 K]);

ix =  [800,190];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',[0.10 0.10 0.10]);%

ix =  [100,100];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',3.*[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',3.*[0.10 0.10 0.10]);%

ix =  [450,500];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',6.*[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',6.*[0.10 0.10 0.10]);%
box off;
plot([0 K],[K 0],'-k');
plot(0,K*(1-d/r),'o','Color',[0, 0.4470, 0.7410],'LineWidth',1,'MarkerSize',5);
plot(K,0,'o','Color',[0.8500, 0.3250, 0.0980],'LineWidth',3,'MarkerSize',2);
title('C');subtitle('Case II $\left(r\frac{c-1}{c}<\delta<r\right)$','FontSize',10,'Interpreter','latex'); 
%
params = [0.02 1000 0.01 3]; 
r = params(1); K = params(2); d= params(3); c = params(4);%we need this for drawing the nullcines
T = 5000;
Step = 1; R = 0:Step:K;
SS = @(R) K*(1-d/r)-R;%S-nullcine
SR = @(R) (K-R)./c;%R-nullcine


subplot(3,3,7)
x_eq = [K*d/(r*(c-1)) c*K*(1- d/r - 1/c)/(c-1)];
plot(R,SS(R),':','LineWidth',1,'Color',[0, 0.4470, 0.7410]); xlabel('R'); ylabel('S'); hold on
plot(R,SR(R),':','LineWidth',1,'Color',[0.8500, 0.3250, 0.0980]); xlim([0 K]); ylim([0 K]);

ix =  [800,190];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',[0.10 0.10 0.10]);%

ix =  [100,100];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',3.*[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',3.*[0.10 0.10 0.10]);%

ix =  [450,500];% initial conditions
plot(ix(2),ix(1), 'd','LineWidth',1,'Color',6.*[0.10 0.10 0.10],'MarkerSize',3);%
[t,x] = ode45(@model,1:1:T,ix,[],params);
plot(x(:,2),x(:,1), '--','LineWidth',1,'Color',6.*[0.10 0.10 0.10]);%
box off;
plot([0 K],[K 0],'-k');
plot(0,K*(1-d/r),'o','Color',[0, 0.4470, 0.7410],'LineWidth',3,'MarkerSize',2);
plot(K,0,'o','Color',[0.8500, 0.3250, 0.0980],'LineWidth',3,'MarkerSize',2);
title('B');subtitle('Case III $\left(0<\delta<r\frac{c-1}{c}\right)$','FontSize',10,'Interpreter','latex'); 

sep = [0 0]; ix = sep(end,:)+[0 Step]; threshold = 1;
while sum(sep(end,:))<K
        [t,x] = ode45(@model,1:1:T,ix,[],params);
        if abs(x(end,2)-K)<threshold && abs(x(end,1)-0)<threshold %if approach towards R-only
            ix = ix +[Step 0];%increase S
        else
            sep = [sep; ix-[Step 0]];
            ix = ix +[0 Step];
        end
 end
    plot(sep(:,2),sep(:,1),'k-','LineWidth',1); hold on
