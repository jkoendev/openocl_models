function p560_ocl_dae(eq, x, z, u, ~)

  q = x.q;
  qd = x.qd;
  qdd = z.qdd;
  tau = u.tau;

  torque = p560_torque_generated(q,qd,tau);
  mass = p560_mass_generated(q);
  
  eq.setAlgEquation( mass * qdd.' - torque.' );
  
  eq.setODE('q', qd);
  eq.setODE('qd', qdd);
  
end