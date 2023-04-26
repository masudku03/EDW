%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
function dx = state_ctrl(x,u,params)
rS = params(1); rR = rS; K = params(2); d = params(3); c = params(4);
nsv = size(x);
dx = zeros(nsv(1),1);
 
dx(1) = rS*x(1)*(1-sum(x)/K) - d*u*x(1);   
dx(2) = rR*x(2)*(1-(c*x(1)+x(2))/K);             
