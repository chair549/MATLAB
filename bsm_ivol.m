function iv = bsm_impvol(S, K, r, q, T, type, f, x0)

% Computes implied volatility for vanilla european options, using the BSM Model
% Works for both calls and puts.

%INPUT
% f     : Observed option price
% x0    : initial volatility guess

% S0    : Initial Strike Price
% K     : Strike Price
% rf    : Risk-free Rate
% q     : Dividend Yield
% T     : Term to Maturity
% type  : Option type = Call 'c' or Put 'p'

%OUTPUT
% iv    : implied volatility

iv = fzero(@bsm_val,x0);

% Nested function which calculates the bsm price using a guess x0 for sigma
    function y = bsm_val(sigma)
        
        % As this function is only used inside the fzero() call
        % it needs scalar inputs and outputs.
        
        % Nested functions can use variables that are not explicitly passed as input arguments.

        % Adjusting stock price for dividend yield
        S0_adj = S*exp(-q*T);
        
        d1 = (log(S0_adj / K) + (r + sigma ^ 2/2) * T) / (sigma * T ^ 0.5);
        d2 = d1 - (sigma* T^0.5);
        
        Nd1 = normcdf(d1);
        Nd2 = normcdf(d2);
        
        if type == 'c'
            % valuing as a call
            val = S0_adj*Nd1 - K*exp(-r*T)*Nd2;

        elseif type == 'p'
            % valuing as a put
            val = K*exp(-r*T)*(1-Nd2) - S0_adj*(1-Nd1);
        else
            error('bsm_impvol - Option type invalid, please use c or p')    
        end
        
        y = val - f;
    
    end
end

% Here we need to specifically 'end' both of our functions here!
% To nest any function in a program file, all functions in that file must use an 'end' statement.