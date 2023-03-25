%% TN exercise 2
%% 2.1 (a)
x = 0:0.001:4;
F = -log(2*pi)-0.5*(x-3*ones(size(x))).^2 - 0.5*(x.^2-2*ones(size(x))).^2;
posterior = exp(F);
figure
subplot(211)
plot(x,posterior,'LineWidth',1,'color','k')
xlabel('x','FontSize',15)
ylabel('p(x|y)','FontSize',15)
subtitle('Posterior','FontSize',15)
subplot(212)
plot(x,F,'LineWidth',1,'color','k')
subtitle('F','FontSize',15)
xlabel('x','FontSize',15)
ylabel('F(x)','FontSize',15)

%% 2.1 (b)
phi = 3; % initialize phi
delta = 0.01;
tau = (1:150)*delta;
phiList = [];

for t = tau
    phiList = [phiList phi];
    gradF = -2*phi^3 + 3*phi + 3;
    phi = phi + delta*gradF;
end

figure
plot(tau,phiList,'Color','k','LineWidth',1)
xlabel('\tau','FontSize',15)
ylabel('\phi(\tau)','FontSize',15)
title('Gradient-ascent evolution of \phi','FontSize',15)

%% 2.1 (c)
% initialize phi, epsilon_gen and epsilon_pr
phi = 3; 
epsilonGEN = 0;
epsilonPR = 0; 
phiList = [];
epsilonGENList = [];
epsilonPRList = [];
tau = (1:1000)*delta;

for t = tau
    phiList = [phiList phi];
    epsilonGENList = [epsilonGENList epsilonGEN];
    epsilonPRList = [epsilonPRList epsilonPR];
    phi = phi + delta*(epsilonPR + epsilonGEN*2*phi);
    epsilonGEN = epsilonGEN + delta*(2 - phi^2 - epsilonGEN);
    epsilonPR = epsilonPR + delta*(3 - phi - epsilonPR);
end

figure
plot(tau,phiList,'Color','k','LineWidth',1)
hold on
plot(tau, epsilonPRList,'Color','k','LineStyle','--','LineWidth',1)
plot(tau, epsilonGENList,'Color','k','LineStyle','-.','LineWidth',1)
hold off
xlabel('\tau','FontSize',15)
legend('\phi','\epsilon_{Gen}','\epsilon_{Pr}','FontSize',15)
title('Gradient-ascent evolution of \phi, \epsilon_{Gen} and \epsilon_{Pr}','FontSize',15)

%% 2.2 (b)
% parameter setting:
kappa2 = 1;
omega2 = -4;
omega3 = -6;
% omega3 = -0.5;
theta = exp(omega3);
% initial states:
x2 = 0;
x3 = 1;
x2List = [];
x3List = [];
uList = [];     % binary inputs to be generated

% random walk:
N = 320;
for n = 1:N

    x3List = [x3List x3];
    x2List = [x2List x2];

    delta_x3 = sqrt(theta)*randn(1);    % randomwalk step of x3
    x3 = x3 + delta_x3;
    
    std_x2 = exp(0.5*(kappa2*x3+omega2));
    delta_x2 = std_x2*randn(1);         % randomwalk step of x2
    x2 = x2 + delta_x2;

    s = 1/(1+exp(-x2));                 % sigmoid transform of x2
    u = round(s);
    uList = [uList u];

end

figure
yyaxis left
plot(1:N, x3List,'LineWidth',1)
hold on
plot(1:N, x2List,'LineWidth',1)
yyaxis right
scatter(1:N, uList,'+')
hold off
xlabel('Random walk iteration',FontSize=15)
legend('x_3', 'x_2', 'u',fontsize=15)
title(['\theta = ' num2str(theta)])

%% 2.3 (a)
addpath HGF/
u = load('example_binary_input.txt');
% simulate model
sim = tapas_simModel(u,...
                     'tapas_hgf_binary',... 
                     [NaN 0 1 NaN 1 1 NaN 0 0 1 2.5 NaN -4 -6],...
                     'tapas_unitsq_sgm',...
                     5);
tapas_hgf_binary_plotTraj(sim)

% recover
% prior (beliefs)
hgf_binary_config = tapas_hgf_binary_config()
unitsq_sgm_config = tapas_unitsq_sgm_config()
optim_config = tapas_quasinewton_optim_config()

est = tapas_fitModel(sim.y, sim.u, hgf_binary_config, unitsq_sgm_config, optim_config);

tapas_fit_plotCorr(est)

%% 2.3 (c)

sim = tapas_simModel(u,...
                     'tapas_hgf_binary',... 
                     [NaN 0 2.5 NaN 1 6.25 NaN 0 0 1 1 NaN -4 -4.1674],...
                     'tapas_unitsq_sgm',...
                     5);
tapas_hgf_binary_plotTraj(sim)
