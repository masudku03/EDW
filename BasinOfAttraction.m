% to generate Separatrix.fig
% separatrix
clc, clear
PList = [4 5 6 9 10 14 28 30];
LDH0 = zeros(1,numel(PList));
T = 5*365;
for ipt = 1:numel(PList)
    fname = sprintf('csvData\\p%d.csv',PList(ipt));
    Data = csvread(fname);
    LDH0(ipt) = Data(2,1);
end

figure
params = csvread('fitting.csv',1,1);
u = 0.7;
ipt = 2;

SPTRX(params(ipt,:),LDH0(ipt),T,u)

%%
% To create animation
v = VideoWriter('BofAttraction.mp4','MPEG-4');
open(v);

    figure
    params = csvread('fitting.csv',1,1);
    ipt = 2;
    for u = 0.85:-0.005:0
    SPTRX(params(ipt,:),LDH0(ipt),T,u)
    frame = getframe(gcf);
    clf
    writeVideo(v,frame);
    end
close(v);