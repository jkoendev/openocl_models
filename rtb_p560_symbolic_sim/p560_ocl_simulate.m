function p560_ocl_simulate

  system = ocl.System(@p560_vars, @p560_dae);
  simulator = ocl.Simulator(system);
  
  x0 = simulator.getStates();
  x0.q = [0,0,0,0,0,0];
  x0.qd = [0,0,0,0,0,0];
  
  simulator.reset(x0);

  mdl_puma560

  while true
    [x,~] = simulator.step(0, 0.02);
    p560.plot(x.q.value)
  end

end

function p560_vars(vars)

  vars.addState('q', [1,6]);
  vars.addState('qd', [1,6]);
  
  vars.addAlgVar('mass_inv', [6,6]);
  
  vars.addControl('tau', [1,6]);

end

function p560_dae(eq, x, z, u, p)

  q = x.q;
  qd = x.qd;
  mass_inv = z.mass_inv;
  tau = u.tau;

  torque = p560_torque_generated(q,qd,tau);
  mass = p560_mass_generated(q,qd);
  
  eq.setAlgEquation(mass_inv*mass-eye(6));
  eq.setODE('q', qd);
  eq.setODE('qd', mass_inv * torque.');
  
end