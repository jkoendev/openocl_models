px = 0;
py = 3; 
theta1 = 30*pi/180;
theta2 = -30*pi/180;
r1 = 1;
r2 = 1;

q = [px;py;theta1;theta2;r1;r2];
qd = zeros(6,1);

y = [q;qd];

tspan = linspace(0,2,100);
options = odeset('Mass', @(t,y) blkdiag(eye(6), sw_model_M(y(1:6))) );
[t,Y] = ode45(@simple_walker_ode, tspan, y, options);

% draw
h = simple_walker_draw_prepare();
q = y(1:6);
qd = y(7:12);
simple_walker_draw_frame(h, q, qd);

for k=2:size(Y,1)
  y = Y(k,:)';
  q = y(1:6);
  qd = y(7:12);
  simple_walker_draw_frame(h, q, qd);
  pause(t(k)-t(k-1))
end

