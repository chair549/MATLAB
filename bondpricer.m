function price = bondpricer(FV, T, cr, freq, rate)

%Price a coupon bond. The next coupon payment is exactly 1 payment period away.  

% INPUT
% FV        : face value
% T         : maturity
% cr        : coupon rate
% freq      : coupon payment frequency
% rate      : discount rate, same compounding frequency as coupon payment frequency 

% nper      : number of coupon payment periods
% cf        : vector of coupon cashflows
% timeline  : timeline of cashflows

% OUTPUT
% price     : value of the bond

% this function prices a coupon bond assuming flat term structure


nper = T*freq;
cf = cr*FV/freq*ones(1,T*freq);
cf(end) = cf(end) + FV;                 %Add the FV to the last cashflow
timeline = 1:nper;
price = sum(cf./((1+rate/freq).^timeline));

