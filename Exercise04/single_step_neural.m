function dxdt = single_step_neural(x,u,P)

A = P.A;
B = P.B;
C = P.C;

CON = A + u(2)*B;
CON(1,1) = -0.5*exp(CON(1,1));
CON(2,2) = -0.5*exp(CON(2,2));
dxdt = CON*x + C*[u(1);0];
