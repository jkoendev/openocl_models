syms px py theta1 theta2 r1 r2 real
syms vx vy theta1d theta2d r1d r2d real
syms ax ay theta1dd theta2dd r1dd r2dd real

mc = 1.0;
m1 = 0.5;
m2 = 0.5;

g = 9.81;

p1x = px + r1 * sin(theta1);
p1y = py - r1 * cos(theta1);

p2x = px + r2 * sin(theta2);
p2y = py - r2 * cos(theta2);

v1x = jacobian(p1x, [px, theta1, r1]) * [vx; theta1d; r1d];
v1y = jacobian(p1y, [px, theta1, r1]) * [vx; theta1d; r1d];

v2x = jacobian(p2x, [px, theta2, r2]) * [vx; theta2d; r2d];
v2y = jacobian(p2y, [px, theta2, r2]) * [vx; theta2d; r2d];

Kc = .5 * mc * (vx^2 + vy^2);
K1 = .5 * m1 * (v1x^2 + v1y^2);
K2 = .5 * m2 * (v2x^2 + v2y^2);

Pc = mc * g * py;
P1 = m1 * g * p1y;
P2 = m2 * g * p2y;

L = Kc + K1 + K2 - Pc - P1 - P2;

q = [px py theta1 theta2 r1 r2]';
qd = [vx vy theta1d theta2d r1d r2d]';
qdd = [ax ay theta1dd theta2dd r1dd r2dd]';

partial_L_by_partial_qdot = jacobian(L, qd).';

C = jacobian(L, q).' - jacobian(partial_L_by_partial_qdot, q) * qd;
M = jacobian(partial_L_by_partial_qdot, qd);

% to solve for qdd analytically
% sol = solve(M*qdd==C, qdd);

% M*qdd = C(q,qd) + Jc * fc + fm(q,qd)
%   contact forces fc
%   external force fe

% contact jacobians
Jc1y = jacobian(p1y, q);
Jc2y = jacobian(p2y, q);

Jcy = [Jc1y;Jc2y];

% motor inputs
tau = sym('tau', [2,1], 'real');

% control setpoint 
syms r1s r2s real
Kms = 100;     % motor stiffness
Kmd = 10;       % motor damping

fm = [0;0;tau; Kms*(r1s-r1) - Kmd*(r1d); Kms*(r2s-r2) - Kmd*(r2d)];

% contact force as input
% external forces
syms fc1y fc2y real
fc = [fc1y; fc2y];
fe = Jcy.' * fc + fm;

u = [tau; r1s; r2s; fc];

% contact points
pc = [p1y; p2y];

% generate model functions
matlabFunction(C, 'file', 'sw_model_C', 'Vars', {q;qd});
matlabFunction(M, 'file', 'sw_model_M', 'Vars', {q});
matlabFunction(fe, 'file', 'sw_model_fe', 'Vars', {q,qd,u});
matlabFunction(pc, 'file', 'sw_model_pc', 'Vars', {q});

matlabFunction([p1x;p1y], [p2x;p2y], 'file', 'sw_model_fkine', 'Vars', {q});



