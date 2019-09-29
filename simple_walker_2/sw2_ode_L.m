function yd = sw2_ode_L(~,y,u)

m = 1;
g = 9.81;

theta1dd = u(1); % no effect in L
theta2dd = u(2);
r1dd = u(3);
r2dd = u(4);

p = y(1:2);
theta1 = y(3);
theta2 = y(4);
r1 = y(5);
r2 = y(6);

v = y(7:8);
theta1d = y(9);
theta2d = y(10);
r1d = y(11);
r2d = y(12);

lambda1 = y(13);
theta1dd = y(14);

q = vertcat(p, theta1, theta2, r1, r2);
qd = vertcat(v, theta1d, theta2d, r1d, r2d);

[p1, p2] = sw2_fkine(q, qd);

fc1 = (p-p1) * lambda1;
fc2 = 0; %(p-p2) * lambda2;

a = [0; -m*g] + fc1 + fc2;

qdd = zeros(6,1);
qdd(1:2) = a;
qdd(3) = theta1dd;
qdd(4) = theta1dd + theta2dd;
qdd(5) = r1dd;
qdd(6) = r2dd;

[a1, a2] = sw2_fkine_a(q, qd, qdd);

yd = zeros(12,1);
yd(1:6) = qd;
yd(7:12) = qdd;
yd(13) = a1(1);
yd(14) = a1(2);