function sw_ocl_sd_ode_damped(odeh, x, z, u, p)

E = p.E;

q = [x.p; x.theta1; x.theta2; x.r1; x.r2];
qd = [x.v; x.theta1d; x.theta2d; x.r1d; x.r2d];

% contact points
[p1,p2,v1,v2] = sw_model_fkine(q,qd);
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

fe = sw_model_fe(q, qd, sw_u);
C = sw_model_C(q, qd);

qdd = C + fe;

yd = [qd;qdd];

odeh.setODE('p', yd(1:2));
odeh.setODE('theta1', yd(3));
odeh.setODE('theta2', yd(4));
odeh.setODE('r1', yd(5));
odeh.setODE('r2', yd(6));

odeh.setODE('v', yd(7:8));
odeh.setODE('theta1d', yd(9));
odeh.setODE('theta2d', yd(10));
odeh.setODE('r1d', yd(11));
odeh.setODE('r2d', yd(12));