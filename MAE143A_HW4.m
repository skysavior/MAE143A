%% Luz Nogueira
% MAE 143 A Homework 4
clear all; close all; clc; 
%% 1 (incomplete)
g = (s+2)*(s-2)*(s+4)*(s-4)/((s+1)*(s-1)*(s+3)*(s+5)*(s-5));
f = ((s+1)*(s-1)*(s+3)*(s+5)*(s-5));
% [g,xg,yg]=RR_Bezout(a,b); c=RR_PolyDiv(f,g);
% x=RR_PolyConv(xg,c); y=RR_PolyConv(yg,c); r=-RR_PolyDiv(b,g); t=RR_PolyDiv(a,g);
% [k,y]=RR_PolyDiv(y,t);  x=RR_PolyAdd(x,RR_PolyConv(r,-k)); 
% y=y(find(abs(y)>1e-8,1):end); x=x(find(abs(x)>1e-8,1):end);

%% 3
%Variable initilization
s= tf('s'); % creates a basic transfer function to build the rest
d = 0.1; n = [1,2,4,8];     % Variables given
sys = tf(exp(-d*s));        % Actual function
%padeAprx = cell(numel(n),1);       %Meant to store sysPade TO DO
for j = 1:numel(n)
    sysPade= pade(sys,n(j))
    figure(j); pzplot(sysPade); sgrid; grid on;
end

%% 4
% 4a.) 
figNum = numel(n)+1; figure(figNum);fignum=figNum+1; %Keeping figures organized
figure(figNum);
rlocus(tf([1],[1 0]));
 sgrid; grid on;

%4.b
% I couldn't figue out how to store the individual transfer functions as it
% didn't seem to want to be passed into either a matrix or array
% Created a function to do the work instead. 
figNum = rlocusWork(n,sys,figNum+1);

%4.c
d=0.2;
sys2 = tf(exp(-d*s));
rlocusWork(n,sys2, figNum)

%% Functions
function newFigNum = rlocusWork(nValues,sysin,fignumAdd)
% Creates pade approximations of the order nValues for the transfer
% function sysin and keeps track of what figure is next to be used

    s= tf('s'); % creates a basic transfer function to build the rest
    newFigNum= fignumAdd;
    for j = 1:(numel(nValues))
        sysPade= pade(sysin,nValues(j));
        G = sysPade/s;
        figure(newFigNum);
        rlocus(G);
         sgrid; grid on;
        newFigNum = newFigNum+1;
    end
end