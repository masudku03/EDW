%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023

function SPTRX(params,LDH0,T,u)

    r = params(1); K = params(2); d= params(3); c = params(4); S0r = 0.99; S0 = LDH0*S0r;
    threshold = 1; Step = 1; R = 0:Step:K;  sep = [0 0];
    ix = sep(end,:)+[0 Step];%initial condition
    
    SS = @(R) K*(1-d/r)-R;%nullcines
    SSu = @(R) K*(1-d*u/r)-R;%nullcines
    SR = @(R) (K-R)./c;%nullcines
    %%Equilibrium
    x_eq = [K*d*u/(r*(c-1)) c*K*(1- d*u/r - 1/c)/(c-1)];
    plot((1-S0r)*S0/S0r, S0, 'd','LineWidth',2,'Color',[0.5 0.5 0.5]); hold on%initial point
    plot(R,SR(R),'-','LineWidth',2,'Color',[0.8500, 0.3250, 0.0980]); xlim([0 K]); ylim([0 K]);%R-nullcline
    plot(K, 0,'.','LineWidth',2,'Color',[0.8500, 0.3250, 0.0980],'MarkerSize',30);%R-only equilibrium
    plot(R,SS(R),':','LineWidth',2,'Color',[0, 0.4470, 0.7410]); xlabel('R'); ylabel('S'); %
    plot(0, K*(1- d/r),'o','LineWidth',2,'Color',[0, 0.4470, 0.7410]);%
    plot(R,SSu(R),':','LineWidth',2,'Color',[0.5, 0.4470, 0.7410]); xlabel('R'); ylabel('S'); hold on
    plot(0, K*(1- d*u/r),'.','LineWidth',2,'Color',[0.5, 0.4470, 0.7410],'MarkerSize',30);%
    plot(x_eq(2), x_eq(1),'*','MarkerSize',10,'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880]);%

    %separatrix
    while sum(sep(end,:))<K
        [t,x] = ode45(@model,1:1:T,ix,[],params.*[1 1 u 1]);
        if abs(x(end,2)-K)<threshold && abs(x(end,1)-0)<threshold %if approach towards R-only
            ix = ix +[Step 0];%increase S
        else
            sep = [sep; ix-[Step 0]];
            ix = ix +[0 Step];
        end
    end
    plot(sep(:,2),sep(:,1),'k-','LineWidth',1); hold on
    
    legend('Initial Point','R-nullcline','R-only Equilibrium','S-nullcline_{MTD}','Unstable S-only Equilibrium','S-nullcline_{0.7 MTD}','Stable S-only Equilibrium','Coexistent Equilibrium','Separatrix','AutoUpdate','off');
    box off;
    plot([0 K],[K, 0],'k-');
end