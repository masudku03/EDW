%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
function u = control(x,ld,nc,M,B1,params)
rS = params(1); rR = rS; K = params(2); d = params(3); c = params(4);
u = zeros(nc,M+1); 
u(1,:) = (d.*ld(1,:).*x(1,:))/B1;

