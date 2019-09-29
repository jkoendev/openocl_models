function sw2_ocl_dae_L(dh, x, z, u, p)

q = x.q;
qd = x.qd;

lambda1 = z.lambda1;
theta1dd = z.theta1dd;

theta2dd = u.theta2dd;
r1dd = u.r1dd;
r2dd = u.r2dd;

y = [q;qd;lambda1;theta1dd];

yd = sw2_ode_L([],y);

qdd = yd(7:12);

dh.setODE('q', qd);
dh.setODE('qd', qdd);

dh.setAlgEquation(y(13));
dh.setAlgEquation(y(14));
