function dhdt = single_step_hrf(h,x,Phrf)

s = h(:,1);
f = h(:,2);
v = h(:,3);
q = h(:,4);

kappa = Phrf.kappa;
gamma = Phrf.gamma;
tau = Phrf.tau;
alpha = Phrf.alpha;
E0 = Phrf.E0;

dsdt = x - kappa*s - gamma*(f-ones(size(f)));
dfdt = s;
dvdt = (1/tau).*(f-v.^(1/alpha));
dqdt(1) = (1/tau)*(f(1)*(1-(1-E0)^(1/f(1)))/E0 - v(1)^(1/alpha)*q(1)/v(1));
dqdt(2) = (1/tau)*(f(2)*(1-(1-E0)^(1/f(2)))/E0 - v(2)^(1/alpha)*q(2)/v(2));

dhdt = zeros(size(h));
dhdt(:,1) = dsdt;
dhdt(:,2) = dfdt;
dhdt(:,3) = dvdt;
dhdt(:,4) = dqdt;
