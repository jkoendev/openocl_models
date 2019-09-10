syms px py theta1 theta2 r1 r2 real
syms vx vy theta1d theta2d r1d r2d real
syms ax ay theta1dd theta2dd r1dd r2dd real

q = [px py theta1 theta2 r1 r2].';
qd = [vx vy theta1d theta2d r1d r2d].';
qdd = [ax ay theta1dd theta2dd r1dd r2dd].';

mc = 1.0;
m1 = 1;
m2 = 1;

r1e = 1.0;
r2e = 1.0;

g = 9.81;

p1x = px + r1 * sin(theta1);
p1y = py - r1 * cos(theta1);

p2x = px + r2 * sin(theta2);
p2y = py - r2 * cos(theta2);

v1x = jacobian(p1x, q) * qd;
v1y = jacobian(p1y, q) * qd;

v2x = jacobian(p2x, q) * qd;
v2y = jacobian(p2y, q) * qd;

a1x = jacobian(v1x, q) * qd + jacobian(v1x, qd) * qdd;
a1y = jacobian(v1y, q) * qd + jacobian(v1y, qd) * qdd;

a2x = jacobian(v2x, q) * qd + jacobian(v2x, qd) * qdd;
a2y = jacobian(v2y, q) * qd + jacobian(v2y, qd) * qdd;

Kc = .5 * mc * (vx^2 + vy^2);
K1 = .5 * m1 * (v1x^2 + v1y^2);
K2 = .5 * m2 * (v2x^2 + v2y^2);

Pc = mc * g * py;
P1 = m1 * g * p1y;
P2 = m2 * g * p2y;

L = Kc + K1 + K2 - Pc - P1 - P2;

partial_L_by_partial_qdot = jacobian(L, qd).';

C = jacobian(L, q).' - jacobian(partial_L_by_partial_qdot, q) * qd;
M = jacobian(partial_L_by_partial_qdot, qd);

% M*qdd = C(q,qd) + Jc * fc + fm(q,qd)
%   contact forces fc
%   external force fe

% contact jacobians
Jc = jacobian([p1x, p1y, p2x, p2y], q);

% motor inputs, control setpoint 
syms tau r1tau r2tau real
Kms = 300;      % motor stiffness
Kmd = 30;       % motor damping
Ktaud = 10;

fm = [0;0; tau - Ktaud*theta1d; -tau - Ktaud*theta2d; Kms*(r1e-r1) - Kmd*(r1d) + r1tau*100; Kms*(r2e-r2) - Kmd*(r2d) + r2tau*100];

% contact force as input
% external forces
syms fc1x fc1y fc2x fc2y real
fc = [fc1x; fc1y; fc2x; fc2y];
fe = Jc.' * fc + fm;

u = [tau; r1tau; r2tau; fc];

% contact points
pc = [p1y; p2y];

% generate model functions
matlabFunction(C, 'file', 'sw_model_C', 'Vars', {q;qd});
matlabFunction(M, 'file', 'sw_model_M', 'Vars', {q});
matlabFunction(fe, 'file', 'sw_model_fe', 'Vars', {q,qd,u});
matlabFunction(pc, 'file', 'sw_model_pc', 'Vars', {q});

matlabFunction([p1x;p1y], [p2x;p2y], [v1x;v1y], [v2x;v2y], [a1x;a1y], [a2x;a2y], 'file', 'sw_model_fkine', 'Vars', {q,qd,qdd});

% to solve for qdd analytically
% sol = solve(M*qdd==C+fe, qdd);
% qdd_out = [sol.ax sol.ay sol.theta1dd sol.theta2dd sol.r1dd sol.r2dd].';
% matlabFunction(qdd_out, 'file', 'sw_model_qdd', 'Vars', {q,qd,u});


