function r = p560_mass_fcn(~,y)
  q = y(1:6)';
  qd = y(7:12)';
  
  r = blkdiag(eye(6), p560_mass_generated(q,qd));
end