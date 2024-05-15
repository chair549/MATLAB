function Rc = dis2cont(Rm, m)

% Convert an interest rate with m compounding frequency into a continuously
% compounded rate.

% INPUT
% Rm    : per annum interest rate with compounding frequency m
% m     : compounding frequency 

% OUTPUT
% Rc    : continuously compounded rate

Rc = m.*log(1 + Rm./m);

