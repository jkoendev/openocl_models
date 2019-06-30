addpath('export')
addpath('ocl_model')

mdl_puma560
q0 = p560.qn;

solver = ocl.Solver(1, @p560_ocl_vars, @p560_ocl_dae, @p560_ocl_cost);

solver.setInitialBounds('q', q0);
% solver.setInitialBounds('qd', zeros(6,1));

solver.setBounds('tau', -0.1, 0.1);

mass0 = p560_mass_generated(q0);

ig = solver.ig();
ig.integrator.algvars.mass_inv.set(inv(mass0));
ig.states.q.set(q0)
ig.integrator.states.q.set(q0);

[sol,times] = solver.solve(ig);

q_traj = sol.states.q.value.';

figure
p560.plot3d(q_traj)

