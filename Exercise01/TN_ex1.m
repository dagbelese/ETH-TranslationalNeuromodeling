%% Translational Neuromodeling Exercise 1: Bayesian inference
%% 1.1 (c)
rng(1)          % seed
theta0 = 0.3;
theta1 = -0.1;
theta2 = 0.5;
sigma2 = 0.001;

x = -0.5:0.1:0.2;
epsilon = sigma2 * randn(size(x));

y = theta0 + theta1 * x + theta2 * x.^2 + epsilon;

%% draw
figure;
plot(x,y,'k')
xlabel('x')
ylabel('y = \theta_0 + \theta_1 * x + \theta_2 * x^2 + \epsilon')

%% 1.1 (d)
% P = 2:
p2 = polyfit(x,y,2);
% P = 1:
p1 = polyfit(x,y,1);
% P = 7:
p7 = polyfit(x,y,7);

% Log-likelihood:
N = length(x);
LL2 = -N*log(sqrt(2*pi*sigma2)) - (1/2/sigma2)*sum((y-polyval(p2,x)).^2)
LL1 = -N*log(sqrt(2*pi*sigma2)) - (1/2/sigma2)*sum((y-polyval(p1,x)).^2)
LL7 = -N*log(sqrt(2*pi*sigma2)) - (1/2/sigma2)*sum((y-polyval(p7,x)).^2)

%% 1.1 (e)
% increase x
x = -0.5:0.01:0.5;
epsilon = sigma2 * randn(size(x));
y = theta0 + theta1 * x + theta2 * x.^2 + epsilon;

% keep p1, p2, p7 same as in (d)
LL2 = -N*log(sqrt(2*pi*sigma2)) - (1/2/sigma2)*sum((y-polyval(p2,x)).^2)
LL1 = -N*log(sqrt(2*pi*sigma2)) - (1/2/sigma2)*sum((y-polyval(p1,x)).^2)
LL7 = -N*log(sqrt(2*pi*sigma2)) - (1/2/sigma2)*sum((y-polyval(p7,x)).^2)

%% 1.1 (f)
p2Record = [];
p1Record = [];
p7Record = [];
for count = 1:100
    rng(count) % seed
    epsilon = sigma2 * randn(size(x));
    y = theta0 + theta1 * x + theta2 * x.^2 + epsilon;
    p2 = polyfit(x,y,2);
    p1 = polyfit(x,y,1);
    p7 = polyfit(x,y,7);
    p2Record = [p2Record;p2];
    p1Record = [p1Record;p1];
    p7Record = [p7Record;p7];
end

%% draw
figure;
histogram(p2Record(:,1),'LineStyle','none')
hold on
histogram(p2Record(:,2),'LineStyle','none')
histogram(p2Record(:,3),'LineStyle','none')
hold off
legend('\theta_2','\theta_1','\theta_0')
title('P = 2')

figure
histogram(p1Record(:,1),'LineStyle','none')
hold on
histogram(p1Record(:,2),'LineStyle','none')
hold off
legend('\theta_1','\theta_0')
title('P = 1')

figure
histogram(p7Record(:,1),'LineStyle','none')
hold on
histogram(p7Record(:,2),'LineStyle','none')
histogram(p7Record(:,3),'LineStyle','none')
histogram(p7Record(:,4),'LineStyle','none')
histogram(p7Record(:,5),'LineStyle','none')
histogram(p7Record(:,6),'LineStyle','none')
histogram(p7Record(:,7),'LineStyle','none')
histogram(p7Record(:,8),'LineStyle','none')
hold off
legend('\theta_7','\theta_6','\theta_5','\theta_4','\theta_3','\theta_2','\theta_1','\theta_0')
title('P = 7')

%% 1.2 (c)
rng(1)          % seed
x = -0.5:0.1:0.2;
x = x';
epsilon = sigma2 * randn(size(x));
X1 = [ones(size(x)),x];
X2 = [ones(size(x)),x,x.^2];
X7 = [ones(size(x)),x,x.^2, x.^3, x.^4, x.^5, x.^6, x.^7];
y = theta0 * ones(size(x)) + theta1 * x + theta2 * x.^2 + epsilon.* ones(size(x));
B1 = ridge(y,X1,1)
B2 = ridge(y,X2,1)
B7 = ridge(y,X7,1)

%% 1.2 (d)
B2Record = [];
B1Record = [];
B7Record = [];
for count = 1:100
    rng(count)
    epsilon = sigma2 * randn(size(x));
    y = theta0 * ones(size(x)) + theta1 * x + theta2 * x.^2 + epsilon.* ones(size(x));
    B1 = ridge(y,X1,1);
    B2 = ridge(y,X2,1);
    B7 = ridge(y,X7,1);
    B2Record = [B2Record;B2'];
    B1Record = [B1Record;B1'];
    B7Record = [B7Record;B7'];
end

%% draw
figure;
histogram(B2Record(:,1),'LineStyle','none')
hold on
histogram(B2Record(:,2),'LineStyle','none')
histogram(B2Record(:,3),'LineStyle','none')
hold off
legend('\theta_2','\theta_1','\theta_0')
title('P = 2')

figure
histogram(B1Record(:,1),'LineStyle','none')
hold on
histogram(B1Record(:,2),'LineStyle','none')
hold off
legend('\theta_1','\theta_0')
title('P = 1')

figure
histogram(B7Record(:,1),'LineStyle','none')
hold on
histogram(B7Record(:,2),'LineStyle','none')
histogram(B7Record(:,3),'LineStyle','none')
histogram(B7Record(:,4),'LineStyle','none')
histogram(B7Record(:,5),'LineStyle','none')
histogram(B7Record(:,6),'LineStyle','none')
histogram(B7Record(:,7),'LineStyle','none')
histogram(B7Record(:,8),'LineStyle','none')
hold off
legend('\theta_7','\theta_6','\theta_5','\theta_4','\theta_3','\theta_2','\theta_1','\theta_0')
title('P = 7')
