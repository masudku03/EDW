%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
function dxdt = model(t,x,params)
r = params(1); K = params(2); d = params(3); c = params(4);
dxdt = zeros(length(x),1);
dxdt(1) = r*x(1)*(1-sum(x)/K) - d*x(1);
dxdt(2) = r*x(2)*(1-(c*x(1)+x(2))/K); 
            