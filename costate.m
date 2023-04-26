%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
function dld = costate(x,ld,u,K0,params)
rS = params(1); rR = rS; K = params(2); d = params(3); c = params(4);
nsv = size(x);
dld = zeros(nsv(1),1);
N = sum(x);
dld(1) = -1 - ld(1)*(rS*(1-(2*x(1)+x(2))/K) - u*d) - ld(2)*(-rR*c*x(2)/K);
dld(2) = -1 + ld(1)*rS*x(1)/K - ld(2)*rR*(1-(c*x(1)+2*x(2))/K);
