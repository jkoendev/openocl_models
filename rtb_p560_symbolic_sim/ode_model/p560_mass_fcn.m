function r = p560_mass_fcn(~,y)
  q = y(1:6)';
  
  r = blkdiag(eye(6), p560_mass_generated(q));
end