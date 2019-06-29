function p560_ocl_optimize

  solver = ocl.Solver(3, @p560_vars, @p560_dae, @p560_cost);

  solver.setInitialBounds('q', [0,0,0,0,0,0]);
  solver.setInitialBounds('qd', [0,0,0,0,0,0]);
  
  [sol,times] = solver.solve(solver.ig());

  mdl_puma560
  
  p560.plot3d(sol.states.q.value)

end

function p560_cost(cost, x, z, u, p)

  e = x.q';
  cost.add(e.'*e);

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
