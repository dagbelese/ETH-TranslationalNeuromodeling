
%% 5.2
%% a)
mu = 1;
tau = 1;
N = 10;

% y = epsilon + mu
% y = N samples from a univariate gaussian distribution + mu
y = normrnd(0,tau,[1,N]) + (zeros(N,1) + mu)';


% define starting parameters
mu_0 = 0;
lambda_0 = 3;
a_0 = 2;
b_0 = 2;


%% e)
[m, s_2, a, b, F_arr] = vb(y, mu_0, lambda_0, a_0, b_0, N, 1);

% posterior parameters: μ and τ
tau_post = gamrnd(a,b); % τ is given by gamma distribution with parameters a and b
mu_post = normrnd(m, s_2); % μ is given by gaussian distribution with parameters m and s_2
posterior = tau_post * mu_post; % posterior

results_prior = [m, s_2, a, b, F_arr(end), tau_post, mu_post, posterior];


% with random starting values
results_rand = [0, 0, 0, 0, 0, 0, 0, 0];
for i = 1:10
    % 0 as the last parameter indicates that no prior is given
    [m, s_2, a, b, F_arr] = vb(y, mu_0, lambda_0, a_0, b_0, N, 0);

    % get posterior parameters and store results
    tau_post = gamrnd(a,b);
    mu_post = normrnd(m, s_2);
    results_rand = vertcat(results_rand, [m, s_2, a, b, F_arr(end), tau_post, mu_post, tau_post * mu_post]);
           
end
    


%% d)
% loop for iterations
function [m, s_2, a, b, F_arr] = vb(y, mu_0, lambda_0, a_0, b_0, N, prior)

    % get y mean from y data
    y_mean = mean(y);

    % starting values
    if (prior)
        a = a_0;
        b = b_0;
        m = mu_0;
        s_2 = b_0 / (a_0 * lambda_0);
    else
        % random starting variables
        a = 6 * rand(1,1) + 0.00001; % range 0.00001 to 6
        b = 6 * rand(1,1) + 0.00001; % range 0.00001 to 6
        m = 4 * rand(1,1) - 2; % range -2 to 2
        s_2 = 1 * rand(1,1) + 0.00001; % range 0.00001 to 1

    end
    
    % initialize Free energy vector
    F_arr = []; 
    F_arr = [F_arr 0]; 
    
    while 1

        %% b)
        % update equations for mu
        tau_mean = a/b;
        s_2 = 1 / (tau_mean * (N + lambda_0));
        m = (lambda_0 * mu_0 + N * y_mean) / (lambda_0 + N);
        
        % update equations for tau
        a = a_0 + ((N + 1) / 2);
        b = b_0 + 1/2 * (sum((y - (zeros(N,1) + m)').^2) + lambda_0 * (mu_0 - m)^2 + (N + lambda_0) * s_2);
        
        %% c)
        % evaluate free energy F
        F = -a * log(b) + gammaln(a) - gammaln(a_0) + a_0 * log(b_0) + 1/2 * log(lambda_0) + log(sqrt(s_2)) - N/2 * log(2*pi) + 1/2;
        
        %% d)
        % difference between consecutive iterations
        diff = abs(F - F_arr(end));
        % store F value
        F_arr = [F_arr F];
    
        % break if difference is below threshold
        if diff < 0.001
            break
        end
        
    end
end


