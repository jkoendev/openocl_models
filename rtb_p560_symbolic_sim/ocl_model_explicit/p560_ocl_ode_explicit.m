function p560_ocl_ode_explicit(eq, x, z, u, p)

  q = x.q;
  qd = x.qd;
  tau = u.tau;

  torque = p560_torque_generated(q,qd,tau);
  qdd = mldivide(p560_mass_generated(q), torque.');
  
  eq.setODE('q', qd);
  eq.setODE('qd', qdd);
  
end