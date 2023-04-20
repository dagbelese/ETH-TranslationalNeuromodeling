function y = compute_bold_signal(h,Phrf)
%
s = h(:,1);
f = h(:,2);
v = h(:,3);
q = h(:,4);

% @3Tesla
V0 = 0.04;
theta0 = 80.6; %[s^-1]
r0 = 110; %[s^-1]
TE = 0.035; %[s]
E0 = Phrf.E0;
epsilon = 0.47;

k1 = 4.3*theta0*E0*TE;
k2 = epsilon*r0*E0*TE;
k3 = 1-epsilon;

y = zeros(size(s));
y(1) = V0*(k1*(1-q(1)) + k2*(1-q(1)/v(1)) + k3*(1-v(1)));
y(2) = V0*(k1*(1-q(2)) + k2*(1-q(2)/v(2)) + k3*(1-v(2)));