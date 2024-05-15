function [price] = binary_bsmpricer(S0, K, M, r, sigma, T,type, bintype, q)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
S0_adj = S0.*exp(-q.*T);
d1 = (log(S0_adj ./ K) + (r + sigma .^ 2/2).*T) ./ (sigma .* T .^ 0.5);
d2 = d1 - (sigma .* T .^ 0.5);
Nd1 = normcdf(d1);
Nd2 = normcdf(d2);

    if type =='c'
        if bintype=="A"
            price=S0_adj*Nd1;
        elseif bintype=="M"
            price=exp(-r*T)*M*Nd2;
        end
    elseif type=='p'
        if bintype=="A"
            Nd1 = normcdf(-d1);
            price=S0_adj*Nd1;
        elseif bintype=="M"
            Nd2 = normcdf(-d2);
            price=exp(-r*T)*M*Nd2;
        end
    end
end

