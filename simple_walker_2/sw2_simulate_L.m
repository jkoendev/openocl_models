
T = 3;
N = 100;

px = 0;
py = 1; 
theta1 = -5*pi/180;
theta2 = 10*pi/180;
r1 = 1;
r2 = 1;

q = [px;py;theta1;theta2;r1;r2];
qd = zeros(6,1);

y = [q;qd;1;1];

u = [0;0;0;0];

tspan = linspace(0,T,N);
options = odeset('Mass', sw2_mass_LR );
[t,Y] = ode15s(@(t,y)sw2_ode_L(t,y,u), tspan, y, options);

% draw
[fig,h] = sw2_draw_prepare();
q = y(1:6);
qd = y(7:12);
sw2_draw_frame(h, q, qd);

for k=2:size(Y,1)
  y = Y(k,:)';
  q = y(1:6);
  qd = y(7:12);
  sw2_draw_frame(h, q, qd);
  
  pause(t(k)-t(k-1))
end


