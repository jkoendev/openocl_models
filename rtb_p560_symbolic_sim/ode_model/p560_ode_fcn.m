function yd = p560_ode_fcn(~, y)
  q = y(1:6)';
  qd = y(7:12)';
  tau = zeros(1, 6);
  
  qdd = p560_torque_generated(q, qd, tau);
  
  yd = zeros(12,1);
  yd(1:6) = qd';
  yd(7:12) = qdd';
end