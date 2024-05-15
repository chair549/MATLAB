function price = montecarlo_pricer_vanilla(S0, K, r, y, sigma, T, type, NoSamples)

% Values plain vanilla European options using Monte Carlo simulation

% dividend (single value only)
%INPUT
% S0        : Initial Price
% K         : Strike Price
% r        : Risk-free Rate
% y         : dividend yield
% sigma     : stock volatility
% T         : Term to Maturity
% type      : Option type = Call 'c' or Put 'p'
% NoSim     : Number of simulations or sample sizes

%OUTPUT
% price  : option value


%% Simulate terminal stock prices and compute option price
ST=S0*exp((r-y-sigma^2/2)*T+sigma*randn(NoSamples,1)*sqrt(T)); %Compute a vector of terminal prices from the generated epsilon
if type == 'c'
    price=exp(-r*T)*mean(max(0,ST-K)); 
elseif type == 'p'
    price=exp(-r*T)*mean(max(0,K - ST));
else
    error('Expected input is c for call or p for put')
end
