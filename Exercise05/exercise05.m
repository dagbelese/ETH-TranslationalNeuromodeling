
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
[m, s_2, a, b, F_arr] = vb(y, mu_0, lambda_0, a_0, b_0, N);

% posterior parameters: μ and τ
tau_post = gamrnd(a,b); % τ is given by gamma distribution with parameters a and b
mu_post = normrnd(m, s_2); % μ is given by gaussian distribution with parameters m and s_2
posterior = tau_post * mu_post; % posterior

%% todo: store [m, s_2, a, b, F_arr], post. params, post.

%% todo: Run the program a few more times starting from random values; although keep in mind that s2, a and b must be positive. 
% Compare solutions between the runs in terms of posterior parameter and free energy at convergence

%% todo:generate random starting values
%% todo: run stuff again
%% todo: calculate posterior params 
%% todo: store [m, s_2, a, b, F_arr], post. params, post.


%% f)
% If you can report the results from one run only, which one would you choose?


%% d)
% loop for iterations
function [m, s_2, a, b, F_arr] = vb(y, mu_0, lambda_0, a_0, b_0, N)

    % get y mean from y data
    y_mean = mean(y);

    % starting values
    a = a_0;
    b = b_0;
    m = mu_0;
    s_2 = b_0 / (a_0 * lambda_0);
    
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


