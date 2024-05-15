function [OptVal] = bsmpricer(S0, K, rf, q, sigma, TtM, type)

%Calculates the price of vanilla european put and call options

d1 = (log(S0./K)+(rf - q + sigma.^2./2).*TtM)./(sigma .* TtM .^0.5);
d2 = d1 - (sigma .* TtM .^0.5);

OptVal = zeros(1, length(S0));

for i = 1:length(type)
    if type(i) == 'c'
        Nd1 = normcdf(d1(i));
        Nd2 = normcdf(d2(i));
        OptVal(i) = S0(i)*exp(-q(i)*TtM(i))*Nd1 - K(i)*exp(-rf(i)*TtM(i))*Nd2;
    elseif type(i) == 'p'
        Nd1 = normcdf(-d1(i));
        Nd2 = normcdf(-d2(i));
        OptVal(i) = K(i)*exp(-rf(i)*TtM(i))*Nd2 - S0(i)*exp(-q(i)*TtM(i))*Nd1;
    else
        error('BSM_EuroPricer - Option type Invalid, please enter c or p');
    end
end