function sw_ocl_ms_dae_R(daeh, x, z, u, p)

q = [x.p; x.theta1; x.theta2; x.r1; x.r2];
qd = [x.v; x.theta1d; x.theta2d; x.r1d; x.r2d];
qdd = z.qdd;

lambda2_x = z.lambda2_x;
lambda2_y = z.lambda2_y;

% control inputs (with contact forces)
tau = u.tau;
r1tau = u.r1tau;
r2tau = u.r2tau;
sw_u = [tau;r1tau;r2tau;0;0;lambda2_x;lambda2_y];

M = sw_model_M(q);
fe = sw_model_fe(q, qd, sw_u);
C = sw_model_C(q, qd);

% contact points (equations)
[p1,p2,v1,v2,a1,a2] = sw_model_fkine(q,qd,qdd);

daeh.setODE('p', qd(1:2));
daeh.setODE('theta1', qd(3));
daeh.setODE('theta2', qd(4));
daeh.setODE('r1', qd(5));
daeh.setODE('r2', qd(6));

daeh.setODE('v', qdd(1:2));
daeh.setODE('theta1d', qdd(3));
daeh.setODE('theta2d', qdd(4));
daeh.setODE('r1d', qdd(5));
daeh.setODE('r2d', qdd(6));

daeh.setODE('time', 1);

daeh.setAlgEquation(M*qdd-C-fe);

daeh.setAlgEquation(a2(1));
daeh.setAlgEquation(a2(2));