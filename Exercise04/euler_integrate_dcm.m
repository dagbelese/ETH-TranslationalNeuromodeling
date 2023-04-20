function [y, h, x] = euler_integrate_dcm(U, P, Phrf, x0, h0)

u = U.u;
dt = U.dt;

x_t = x0;
h_t = h0;

x = [];
h = [];
y = [];

for n = 1:size(u,2)
    x = [x x_t];
    h = [h h_t];

    y_t = compute_bold_signal(h_t,Phrf);
    y = [y y_t];

    dxdt = single_step_neural(x_t,u(:,n),P);
    dhdt = single_step_hrf(h_t,x_t,Phrf);
    x_t = x_t + dxdt*dt;
    h_t = h_t + dhdt*dt;
end