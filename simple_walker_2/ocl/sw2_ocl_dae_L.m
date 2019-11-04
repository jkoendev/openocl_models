function sw2_ocl_dae_L(dh, x, z, u, p)

q = x.q;
qd = x.qd;

lambda1 = z.lambda1;
theta1dd = z.theta1dd;

y = [q;qd;lambda1;theta1dd];

yd = sw2_ode_L([],y, [0;u.theta2dd;u.r1dd;u.r2dd]);

qdd = yd(7:12);

dh.setODE('q', qd);
dh.setODE('qd', qdd);

dh.setAlgEquation(yd(13));
dh.setAlgEquation(yd(14));

