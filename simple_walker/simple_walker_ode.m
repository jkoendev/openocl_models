function yd = simple_walker_ode(t,y)

E = 10;

q = y(1:6);
qd = y(7:12);

% contact points
[p1,p2,v1,v2,~,~] = sw_model_fkine(q,qd,0*qd);
pcy = [p1(2); p2(2)];
vcx = [v1(1); v2(1)];

vcy = [v1(2); v2(2)];

% fcy = (sign(-pcy)+1)/2 .* abs(pcy) .* E;
fcy = log(1+2.^(-pcy*E)) ./ log(2);

% damping unilateral
fcy = fcy + fcy.*10.* log(1+2.^(-vcy.*10)) ./ log(2)./10;

% damping 
% fcy = fcy + fcy.*10.*(-vcy);

% static friction
mu_s = 1;
fcx_max = fcy*mu_s;
fcx = -fcy .* vcx .* 100;
fcx = min(fcx, fcx_max);

if t > 3
  fcy = fcy + 10;
end

% control inputs (with contact forces)
u = [0;0;0;fcx(1);fcy(1);fcx(2);fcy(2)];

fe = sw_model_fe(q,qd,u);
C = sw_model_C(q,qd);

qdd = C + fe;

yd = [qd;qdd];