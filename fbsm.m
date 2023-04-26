%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
%Forward Backward Sweep Method
% this code is inherited from the following book.
% Lenhart, S. & Workman, J. T. Optimal Control Applied to Biological Models (Chapman and Hall CRC, London, 2007).
function [t,x,u,ld] = fbsm(ix,T,M,nc,K0,B1,ef,params,theta)%make change according to the objective function#######
delta = 0.0001;%tollerence
t = linspace(0,T,M+1);dt = T/M; dt2 = dt/2; dt6 = dt/6;
n = max(size(ix));
cache = zeros(n,4);

x = zeros(n,M+1); ld = 0*ones(n,M+1); u = zeros(nc,M+1); %initialize state, costate, and control
ld(1,M+1)=theta; % transversality condition
x(:,1) = ix; % initial condition

test = -1;
while(test<0)
ou = u; ox = x; old = ld;
for i = 1:M
    cache(:,1) = state_ctrl(x(:,i),u(:,i),params);%[m11 m12 m13 m14]'
    cache(:,2) = state_ctrl(x(:,i)+dt2.*cache(:,1),(u(:,i)+u(:,i+1))./2,params);%[m21 m22 m23 m24]'
    cache(:,3) = state_ctrl(x(:,i)+dt2.*cache(:,2),(u(:,i)+u(:,i+1))./2,params);%[m31 m32 m33 m34]'
    cache(:,4) = state_ctrl(x(:,i)+dt.*cache(:,3),u(:,i+1),params);%[m41 m42 m43 m44]'
    x(:,i+1) = x(:,i) + dt6.*cache*[1 2 2 1]';
end

for i = M+1:-1:2
    cache(:,1) = costate(x(:,i),ld(:,i),u(:,i),K0,params);
    cache(:,2) = costate((x(:,i)+x(:,i-1))./2,ld(:,i)-dt2.*cache(:,1),(u(:,i)+u(:,i-1))./2,K0,params);
    cache(:,3) = costate((x(:,i)+x(:,i-1))./2,ld(:,i)-dt2.*cache(:,2),(u(:,i)+u(:,i-1))./2,K0,params);
    cache(:,4) = costate(x(:,i-1),ld(:,i)-dt.*cache(:,3),u(:,i-1),K0,params);
    ld(:,i-1) = ld(:,i) - dt6.*cache*[1 2 2 1]';
end

u = control(x,ld,nc,M,B1,params);
Bddu1 = min(ef(1),max(0,u(1,:))); u = (ou(1,:)+Bddu1)./2;

t1 = min(delta.*sum(abs(u),2) - sum(abs(ou - u),2));
t2 = min(delta.*sum(abs(x),2) - sum(abs(ox - x),2));
t3 = min(delta.*sum(abs(ld),2) - sum(abs(old - ld),2));
test = min(min(min(t1,t2),t3))
end