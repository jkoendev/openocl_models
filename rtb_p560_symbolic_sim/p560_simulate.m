function [t,y] = p560_simulate
  q0 = [0,0,0,0,0,0];
  qd0 = [0,0,0,0,0,0];
  
  y0 = [q0, qd0]';

  tspan = 0:0.01:1;
  options = odeset('Mass',@p560_mass_fcn);
  [t, y] = ode15s(@p560_ode_fcn, tspan, y0, options);
end

function r = p560_mass_fcn(~,y)
  q = y(1:6)';
  qd = y(7:12)';
  
  r = blkdiag(eye(6), p560_mass_generated(q,qd));
end

function yd = p560_ode_fcn(~, y)
  q = y(1:6)';
  qd = y(7:12)';
  tau = ones(1, 6);
  
  qdd = p560_torque_generated(q, qd, tau);
  
  yd = zeros(12,1);
  yd(1:6) = qd';
  yd(7:12) = qdd';
end
