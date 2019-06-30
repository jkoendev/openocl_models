function p560_ocl_dae(eq, x, z, u, p)

  q = x.q;
  qd = x.qd;
  mass_inv = z.mass_inv;
  tau = u.tau;

  torque = p560_torque_generated(q,qd,tau);
  mass = p560_mass_generated(q);
  
  eq.setAlgEquation(mass_inv*mass-eye(6));
  eq.setODE('q', qd);
  eq.setODE('qd', mass_inv * torque.');
  
end