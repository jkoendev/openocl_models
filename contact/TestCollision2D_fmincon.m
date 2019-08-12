function TestCollision2D_fmincon

% parameters
g = 9.81;
h = 0.02;
tau = 0;

% particle with position p, velocity v, scalar contact force Fc
m = 1;
p0 = [0;5];
v0 = [13;0];
x0 = [p0;v0;0];

contactForces = [];
heights = [];

figure
title(['tau=' num2str(tau)])

sum_times = 0;

for t=0:h:3
  plot_tic = tic;
  
  % solve 
  lb = [-inf;0;-inf;-inf;0]; % pz>=0,Fc>=0
  opt = optimoptions('fmincon');
  opt.Algorithm = 'sqp';
  opt.Display = 'off';
  meas_tic = tic;
  x0 = fmincon(@(x)0,x0,[],[],[],[],lb,[],@constraints,opt);
  sum_times = sum_times + toc(meas_tic);
  
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

  function [c,ceq] = constraints(x)
    
    % non-linear constraints
    p = x(1:2,1);
    v = x(3:4,1);
    Fc = x(5);
    
    % euler integration (could as well go in linear constriants by rewriting..)
    ceq1 = p - p0 - h*v;              % linear
    ceq2 = v - v0 - h*([0;-g]+Fc*[0;1]/m); % linear
    
    % complementarity condition
    ceq3 = Fc * p(2) - tau;
    ceq = [ceq1;ceq2;ceq3];
   
    c = [];
    
  end

end