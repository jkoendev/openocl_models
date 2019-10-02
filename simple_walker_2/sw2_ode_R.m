function yd = sw2_ode_R(~,y, u)

m = 1;
g = 9.81;

theta1dd = u(1); 
theta2dd = u(2); % no effect in R
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

lambda2 = y(13);
theta2dd = y(14);

q = vertcat(p, theta1, theta2, r1, r2);
qd = vertcat(v, theta1d, theta2d, r1d, r2d);

[p1, p2] = sw2_fkine(q, qd);

fc1 = 0;
fc2 = (p-p2) * lambda2;

a = [0; -m*g] + fc1 + fc2;

qdd = vertcat(a, theta1dd + theta2dd, theta2dd, r1dd, r2dd);

[a1, a2] = sw2_fkine_a(q, qd, qdd);

yd = vertcat(qd, qdd, a2(1), a2(2));
