% 3.3. a)

A = [0, 1, 0, 0; -80^2, -50, 3000, 0; 0, 0, 0, 1; 1000, 0, -50^2, -50];
C = [0 0 0 1];

% Euler's Method
h = 0.001;
t = 0:h:0.2;  % range of t

% workaround to get size of t to create empty x array
x_col = size(t); 
x = zeros(4,x_col(2));

% start values for x
x(:,1) = [0 0 0 0]; % x(t) = 0; t<0

n = numel(t);  % number of x values

% euler's method
for i=1:n-1
    f = A * x(:,i) + (normpdf(t(i),0.05,0.01) * C)';
    x(:,i+1) = x(:,i) + h * f;
end

% get difference to given x_condition_1 values
diff = abs(x - x_condition_1);
max_error = max(diff(:));

% verfication for x1 and x3
diff_row1 = abs(x(1,:) - x_condition_1(1,:));
max_error_x1 = max(diff_row1);
diff_row3 = abs(x(3,:) - x_condition_1(3,:));
max_error_x3 = max(diff_row3);

%%%%%%%%%%%%%%%%%%%%%%%
% 3.3 b)

% single grid searches for the 4 parameters κ1, κ2, af , ab
K1 = linspace(40,120,80); % step size: 1
K2 = linspace(25,75,50); % step size: 1
Ab = linspace(500,1500,100); % step size: 10
Af = linspace(2000,4000,200); % step size: 10

% arrays for exepected variances for grid search of parameters
eXs_K1 = zeros(4, 80);
eXs_K2 = zeros(4, 10);
eXs_Ab = zeros(4, 100);
eXs_Af = zeros(4, 200);

% grid search for k1
for j = 1:80
    A_params = [0, 1, 0, 0; -K1(j)^2, -50, af, 0; 0, 0, 0, 1; ab, 0, -k2^2, -50];
    for i=1:n-1
        f = A_params * x(:,i) + (normpdf(t(i),0.05,0.01) * C)';
        x(:,i+1) = x(:,i) + h * f;
    end
    vE = [1 1 1 1].' - ((var((x_condition_2 - x).').') ./ var(x_condition_2.').');
    eXs_K1(:,j) = vE;
end

% grid search for k2
for j = 1:50
    A_params = [0, 1, 0, 0; -k1^2, -50, af, 0; 0, 0, 0, 1; ab, 0, -K2(j)^2, -50];
    for i=1:n-1
        f = A_params * x(:,i) + (normpdf(t(i),0.05,0.01) * C)';
        x(:,i+1) = x(:,i) + h * f;
    end
    vE = [1 1 1 1].' - ((var((x_condition_2 - x).').') ./ var(x_condition_2.').');
    eXs_K2(:,j) = vE;
end

% grid search for ab
for j = 1:100
    A_params = [0, 1, 0, 0; -k1^2, -50, af, 0; 0, 0, 0, 1; Ab(j), 0, -k2^2, -50];
    for i=1:n-1
        f = A_params * x(:,i) + (normpdf(t(i),0.05,0.01) * C)';
        x(:,i+1) = x(:,i) + h * f;
    end
    vE = [1 1 1 1].' - ((var((x_condition_2 - x).').') ./ var(x_condition_2.').');
    eXs_Ab(:,j) = vE;
end

% grid search for af
for j = 1:200
    A_params = [0, 1, 0, 0; -k1^2, -50, Af(j), 0; 0, 0, 0, 1; ab, 0, -k2^2, -50];
    for i=1:n-1
        f = A_params * x(:,i) + (normpdf(t(i),0.05,0.01) * C)';
        x(:,i+1) = x(:,i) + h * f;
    end
    vE = [1 1 1 1].' - ((var((x_condition_2 - x).').') ./ var(x_condition_2.').');
    eXs_Af(:,j) = vE;
end

% find best eXs values

% max(mean(eXs_Af,1))
% max(mean(eXs_Ab,1))
% max(mean(eXs_K1,1))
% max(mean(eXs_K2,1))

% max(sum(eXs_Af,1))
% max(sum(eXs_Ab,1))
% max(sum(eXs_K1,1))
% max(sum(eXs_K2,1))

% ensuing parameter estimates 
best_K1 = K1(59);
best_eXs_K1 = eXs_K1(:,59);
A_best = [0, 1, 0, 0; -best_K1^2, -50, af, 0; 0, 0, 0, 1; ab, 0, -k2^2, -50];

for i=1:n-1
    f = A_best * x(:,i) + (normpdf(t(i),0.05,0.01) * C)';
    x(:,i+1) = x(:,i) + h * f;
end

% check differences between predicted data from the ensuing parameter estimates and given data
diff_best = abs(x - x_condition_2);
max_error_best = max(diff_best(:));

