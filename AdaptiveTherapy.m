%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023

function [t,y,treatChange] = AdaptiveTherapy(PauseLevel,ResumeLevel,Dose,params,S0,R0,tspan)
t = [1]; y = [S0, R0]; t_temp = 0; treatChange = 1; 
    while t(end)<tspan(end)
        %treatment on
        odeParamsOn = params.*[1,1,Dose,1]; 
        [t_temp,y_temp] = ode45(@(t,y) model(t,y,odeParamsOn),[t(end) tspan(end)],y(end,:));
        if any(find(sum(y_temp,2)<PauseLevel*(S0+R0)))
            treatChange = [treatChange; find(sum(y_temp,2)<PauseLevel*(S0+R0),1)];
            t = [t;t_temp(2:treatChange(end))];
            y = [y;y_temp(2:treatChange(end),:)];
        else
            t = [t;t_temp(2:end)];
            y = [y;y_temp(2:end,:)];
        end
        if t(end)==tspan(end) break; end
        %treatment off
        odeParamsOff = params.*[1,1,0,1];
        [t_temp,y_temp] = ode15s(@(t,y) model(t,y,odeParamsOff),[t(end) tspan(end)],y(end,:));
        if any(find(sum(y_temp,2)>=ResumeLevel*(S0+R0)))
            treatChange = [treatChange; find(sum(y_temp,2)>=ResumeLevel*(S0+R0),1)-1];
            t = [t;t_temp(2:treatChange(end))];
            y = [y;y_temp(2:treatChange(end),:)];
        else
            t = [t;t_temp(2:end)];
            y = [y;y_temp(2:end,:)];
        end
        if t(end)==tspan(end) break; end
    end
end