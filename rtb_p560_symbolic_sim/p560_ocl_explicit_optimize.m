addpath('export')
addpath('ocl_model')
addpath('ocl_cost_constraints')
addpath('ocl_model_explicit')

mdl_puma560
q0 = p560.qz;
qF = p560.qr;
qmin = p560.qlim(:,1)';
qmax = p560.qlim(:,2)';

solver = ocl.Solver(1, @p560_ocl_vars_explicit, @p560_ocl_ode_explicit, ...
                    'pathcosts', @p560_ocl_cost_torques, ...
                    'gridconstraints', @p560_ocl_waypoints);

solver.setInitialBounds('q', q0);
solver.setInitialBounds('qd', zeros(6,1));

solver.setEndBounds('q', qF)

solver.setBounds('q', qmin, qmax);

solver.setBounds('tau', -100, 100);

ig = solver.ig();
ig.states.q.set(q0)
ig.integrator.states.q.set(q0);

[sol,times] = solver.solve(ig);

q_traj = sol.states.q.value.';

figure
p560.plot3d(q_traj)

