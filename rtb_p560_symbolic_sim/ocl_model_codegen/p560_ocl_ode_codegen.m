function p560_ocl_ode_codegen(eq, x, u, robot)

  q = x.q;
  qd = x.qd;
  tau = u.tau;

  qdd = robot.accel(q, qd, tau);
  
  eq.setODE('q', qd);
  eq.setODE('qd', qdd);

end