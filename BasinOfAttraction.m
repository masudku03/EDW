%%% Developed by M A Masud (masudku03@gmail.com, ORCID: 0000-0002-8533-7424) 26th April, 2023
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

