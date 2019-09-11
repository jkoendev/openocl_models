function sw_ocl_sd_dae_damped(daeh, x, z, u, p)

E = p.E;

q = [x.p; x.theta1; x.theta2; x.r1; x.r2];
qd = [x.v; x.theta1d; x.theta2d; x.r1d; x.r2d];
qdd = z.qdd;

% contact points
[p1,p2,v1,v2] = sw_model_fkine(q,qd,0*qd);
pcy = [p1(2); p2(2)];
vcx = [v1(1); v2(1)];
vcy = [v1(2); v2(2)];

% fcy = (tanh(-pcy*E)+1)/2 .* abs(pcy) .* E;
fcy = log(1+2.^(-pcy*E)) ./ log(2);

% damping 
fcy = fcy + fcy.*10.* log(1+2.^(-vcy.*10)) ./ log(2)./10;

% static friction
mu_s = 1;
% fcx_max = fcy*mu_s;
fcx = -fcy .* vcx .* E / 10;

% control inputs (with contact forces)
tau = u.tau;
r1tau = u.r1tau;
r2tau = u.r2tau;
sw_u = [tau;r1tau;r2tau;fcx(1);fcy(1);fcx(2);fcy(2)];

M = sw_model_M(q);
fe = sw_model_fe(q, qd, sw_u);
C = sw_model_C(q, qd);

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

daeh.setAlgEquation(M*qdd-C-fe);
