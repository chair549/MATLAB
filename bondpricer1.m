function price = bondpricer1(FV, T, coupon, freq, rate)

%Price a coupon bond. Determines coupon payment dates.

% INPUT
% FV        : face value
% T         : maturity
% coupon    : coupon rate
% freq      : coupon payment frequency
% rate      : discount rate, same compounding frequency as coupon payment frequency 

% per_len   : length per periods in years
% t1        : timing of the first coupon   
% nper      : number of coupon payment periods
% cf         : vector of coupon cashflows
% timeline   : timeline of cashflows

% OUTPUT
% price      : value of the bond


per_len = 1/freq;
t1 = rem(T,per_len);
timeline = 0: per_len : T-t1;
timeline = timeline + t1;

CF = FV*coupon/freq*ones(1, length(timeline));
CF(end) = CF(end) + FV;

% convert discrete compounded rate to continuous rate

Rc = dis2cont(rate, freq);

% compute bond price using npv

price = npv(CF, timeline, Rc);

