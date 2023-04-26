%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
%Adaptive Forward Backward Sweep Method
% this code is inherited from the following book.
% Lenhart, S. & Workman, J. T. Optimal Control Applied to Biological Models (Chapman and Hall CRC, London, 2007).

function [tc xc u ld a] = secFBSM(ix,T,M,nc,K0,B1,ef,params,a,b,s)%(a,b,r,s)
flag = -1;

[tc xc u ld] = fbsm(ix,T,M,nc,K0,B1,ef,params,a);%this line executes the Forward Backward Sweep Method
Va = xc(1,end) - s;
[tc xc u ld] = fbsm(ix,T,M,nc,K0,B1,ef,params,b);%this line executes the Forward Backward Sweep Method
Vb = xc(1,end) - s;
% the following code executes the secant method
    while(flag < 0)
        if(abs(Va) > abs(Vb))
            k = a;
            a = b;
            b = k;
            k = Va;
            Va = Vb;
            Vb = k;
        end

        d = Va*(b - a)/(Vb - Va);
        b = a;
        Vb = Va;
        a = a - d;
        [tc xc u ld] = fbsm(ix,T,M,nc,K0,B1,ef,params,a);%this line executes the Forward Backward Sweep Method
        Va = xc(1,end) - s;

        if(abs(Va) < 1e-5)
            flag = 1;
        end
    end
%y = z;
end