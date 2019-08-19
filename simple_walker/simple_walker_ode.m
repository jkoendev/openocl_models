function yd = simple_walker_ode(~,y)

E = 100000;

q = y(1:6);
qd = y(7:12);

% contact points
pc = sw_model_pc(q);
fc = (sign(-pc)+1)/2 .* abs(pc) .* E;

% control inputs (with contact forces)
u = [0;0;1;1;fc];

fe = sw_model_fe(q,qd,u);
C = sw_model_C(q,qd);

qdd = C + fe;

yd = [qd;qdd];