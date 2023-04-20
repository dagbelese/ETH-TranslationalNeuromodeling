%% Exercise 04: 4.1.d main

N = 800;
dt = 0.1;
T = (1:N)*dt;

u1 = zeros(size(T));
u1(mod(T,7)==0) = 5;

u2 = zeros(size(T));
u2(30/dt:60/dt) = 1;

u = [u1;u2];
U.u = u;
U.dt = dt;

P.A = [0 0; 1 0];
P.B = [0 0; -0.5 0];
P.C = [1 0; 0 0];

Phrf.kappa = 0.64;
Phrf.gamma = 0.32;
Phrf.tau = 2;
Phrf.alpha = 0.32;
Phrf.E0 = 0.4;

x0 = [0;0];
h0 = [0 1 1 1];
h0 = [h0; h0];

[y, h, x] = euler_integrate_dcm(U, P, Phrf, x0, h0);

%%
figure
subplot(311)
plot(T,u1,'LineWidth',1.5)
hold on
plot(T,u2,'LineWidth',1.5)
hold off
ylim([0,6])
legend('u1','u2')
subplot(312)
plot(T,x(1,:),'LineWidth',1.5)
hold on
plot(T,x(2,:),'LineWidth',1.5)
hold off
legend('x1','x2')
subplot(313)
plot(T,y(1,:),'LineWidth',1.5)
hold on
plot(T,y(2,:),'LineWidth',1.5)
hold off
legend('BOLD1','BOLD2')