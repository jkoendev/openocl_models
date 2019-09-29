
syms px py theta1 theta2 r1 r2 real
syms vx vy theta1d theta2d r1d r2d real
syms ax ay theta1dd theta2dd r1dd r2dd real

q = [px py theta1 theta2 r1 r2].';
qd = [vx vy theta1d theta2d r1d r2d].';
qdd = [ax ay theta1dd theta2dd r1dd r2dd].';

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

this_path = fileparts(which('sw2_sym_model'));

matlabFunction([p1x;p1y], [p2x;p2y], [v1x;v1y], [v2x;v2y], ...
  'file', fullfile(this_path, 'sw2_fkine'), 'Vars', {q,qd,qdd});

matlabFunction([a1x;a1y], [a2x;a2y], ...
  'file', fullfile(this_path, 'sw2_fkine_a'), 'Vars', {q,qd,qdd});

