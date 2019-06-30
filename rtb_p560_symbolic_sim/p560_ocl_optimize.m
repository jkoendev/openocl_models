addpath('export')
addpath('ocl_model')

mdl_puma560
q0 = p560.qn;

solver = ocl.Solver(1, @p560_ocl_vars, @p560_ocl_dae, @p560_ocl_cost);

solver.setInitialBounds('q', q0);
solver.setInitialBounds('qd', zeros(6,1));

solver.setBounds('tau', 0,0)

[sol,times] = solver.solve(solver.ig());

q_traj = sol.states.q.value.';

figure
p560.plot3d(q_traj)

