function TestCollision2D_LCPasQP

% parameters
g = 9.81;
h = 0.02;

% particle with position p, velocity v, scalar contact force Fc
m = 1;
p0 = [0;5];
v0 = [13;0];
x0 = [p0;v0;0];

contactForces = [];
heights = [];

figure

sum_times = 0;

for t=0:h:3
  plot_tic = tic;
  
  % solve LCP using quadprog
  M = h^2 / m;
  q = p0(2)+h*v0(2)-h^2*g;
  
  opt = optimoptions('quadprog');
  opt.Display = 'off';
  meas_tic = tic;
  QP_Fc = quadprog(M,q,-1,0,[],[],[],[],[],opt);
  sum_times = sum_times + toc(meas_tic);
  
  % forward integration (euler) using calculated contact force
  v0 = v0+h*([0;-g]+QP_Fc*[0;1]/m);
  p0 = p0+h*v0;
  x0 = [p0;v0;QP_Fc];
  
  
  % remember result for plotting
  p0 = x0(1:2,1);
  v0 = x0(3:4,1);
  heights = [heights;p0(2)];
  contactForces = [contactForces;x0(5)];
  
  
  % plotting
  subplot(2,2,[1,3])
  plot(p0(1),p0(2),'o');
  hold on
  plot([-1,50],[0,0],'-')
  hold off
  
  xlim([-1,40])
  ylim([-1,40])
  title(t)
  
  subplot(2,2,2)
  plot(0:h:t,contactForces);
  hold on
  xlim([0,3])
  ylim([-10,700])
  title('contact force')
  
  subplot(2,2,4)
  plot(0:h:t,heights);
  hold on
  xlim([0,3])
  ylim([0,5])
  title('height')
  
  % draw
  pause(h-toc(plot_tic))
  drawnow
  
end

disp(['Calculation took: ' num2str(sum_times) ' seconds']);

end