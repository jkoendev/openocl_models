function yd = simple_walker_ode(~,y)

E = 1000;

q = y(1:6);
qd = y(7:12);

% contact points
[p1,p2,v1,v2] = sw_model_fkine(q,qd);
pcy = [p1(2); p2(2)];
vcx = [v1(1); v2(1)];

fcy = (sign(-pcy)+1)/2 .* abs(pcy) .* E;

% static friction
mu_s = 1;
fcx_max = fcy*mu_s;
fcx = -fcy .* vcx .* 100;
fcx = min(fcx, fcx_max);

% control inputs (with contact forces)
u = [0;0;1;1;fcx(1);fcy(1);fcx(2);fcy(2)];

fe = sw_model_fe(q,qd,u);
C = sw_model_C(q,qd);

qdd = C + fe;

yd = [qd;qdd];