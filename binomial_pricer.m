function price = binomial_pricer(S0, K, r, sigma, T, type, NoSteps, varargin)

% Values American Options, both calls and puts, accommodating different
% types of dividends

%INPUTS
% S0        : Initial Stock Price
% K         : Strike Price
% r         : Risk-free Rate
% sigma     : Stock volatility
% T         : Term to Maturity
% type      : Option type = Call 'C' or Put 'P'
% NoSteps   : Number of steps in binomial tree
% varargin  : variable number of other input arguments. 
    % No dividend: enter no extra input argument. 
    % Continuous dividend yield
        % y     :   1 extra input which is the yield.
    % Discrete dividends
        % D     : the dividend vector
        % xdate : time to ex-dividend date vector (in years)

%OUTPUT
% price  : option value


%% Generate Tree parameters
dt=T/NoSteps;           % tree timestep in years
df=exp(-r*dt);         % discount factor
u=exp(sigma*dt ^ 0.5);  % up and down factors
d=1/u;
a=exp((r)*dt);       % compound factor
q=(a-d)/(u-d);          % risk-neutral probability of upward movement


%% Construct the price tree for the stock

% First, preallocate the matrices to hold prices

St=zeros(NoSteps+1,NoSteps+1); % stock  tree
ft=zeros(NoSteps+1,NoSteps+1); % option tree 

% Go through different scenarios of dividend based on the number of
% variable input arguments

n = length(varargin); 

switch n
    case 0  % No dividend
        
        % Populate the tree with prices that are free from dividend:
        St(1,1) = S0;

        % Loop through all of the columns(time steps) of the tree
        for j=1:NoSteps
            for i=1:j       %And every state at the time step 
                St(i,j+1)=St(i,j)*u;          % generate an up and down
                St(i+1,j+1)=St(i,j)*d;   
            end
        end


    case 1 % dividend yield                 
        
        y = varargin{1}; %
        
        % Recalculate a and q
        a=exp((r-y)*dt);       % compound factor
        q=(a-d)/(u-d);          % risk-neutral probability of upward movement
        
        % Populate the price
        St(1,1) = S0;

        % Loop through all of the columns(time steps) of the tree
        for j=1:NoSteps
            for i=1:j       %And every state at the time step 
                St(i,j+1)=St(i,j)*u;          % generate an up and down
                St(i+1,j+1)=St(i,j)*d;   
            end
        end

    case 2  % Scenario 3: discrete dividend
        
        % load input variables for this scenario
        D = varargin{1}; %dividend amount
        xdate = varargin{2}; %dividend timing
        
        % Remove NPV of dividends from initial price
        pv_D = sum(D .* exp(-r.* xdate));
        % Populate the tree with prices that are free from dividend:
        St(1,1) = S0-pv_D;

        % Loop through all of the columns(time steps) of the tree
        for j=1:NoSteps
            for i=1:j       %And every state at the time step 
                St(i,j+1)=St(i,j)*u;          % generate an up and down
                St(i+1,j+1)=St(i,j)*d;   
            end
        end
       
        % Then add back dividend for nodes that occur before ex div date
        tau=0; %Track time through tree steps

        % Iterate through each node of the tree
        for j=1:NoSteps+1

            % check if current node is before the dividend
            for dx=1:length(D)
                if tau < xdate(dx)
                    % If it is, add the dividend back in
                    St(:,j)=St(:,j)+exp(-r*(xdate(dx)-tau))*D(dx);
                end
            end

           tau=tau+dt; %Increase by 1 timestep
        end
end

%% Valuation of the tree at the terminal node
if type=='P'
    ft(:,end)=max(K-St(:,end),0);
elseif type=='C'
    ft(:,end)=max(St(:,end)-K,0);
end

%Step 6 Backwards induction of option price
for j=NoSteps:-1:1   %Stepping backwards by 1 from NoSteps to 1
    for i=1:j

        CV=(q*ft(i,j+1)+(1-q)*ft(i+1,j+1))*df;
        
        %checking Intrinsic Value for early exercise
        if type=='P'
            IV=max(K-St(i,j),0); 
        elseif type=='C'
            IV=max(St(i,j)-K,0);
        end    

        ft(i,j)=max(CV,IV); 

    end
end

% Option price is the first node of the option tree
price = ft(1,1);