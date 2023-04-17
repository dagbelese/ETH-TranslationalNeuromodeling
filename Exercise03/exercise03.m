%%% 3.3. a)

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
diff = abs(x - x_condition_1)
max_error = max(diff(:));

% verfication for x1 and x3
diff_row1 = abs(x(1,:) - x_condition_1(1,:))
max_error_x1 = max(diff_row1)
diff_row3 = abs(x(3,:) - x_condition_1(3,:))
max_error_x3 = max(diff_row3)

%%% 3.3 b)

% single grid searches for the 4 parameters κ1, κ2, af , ab

% Compare the four different hypotheses in terms of the residual sum of squares or explained variance (vE = 1 − var(y − yp)/var(y)) Hint: The true model should at least reach 98% of explained variance).


