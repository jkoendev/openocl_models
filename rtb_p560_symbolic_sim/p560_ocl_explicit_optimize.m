addpath('export')
addpath('ocl_model')
addpath('ocl_cost_constraints')
addpath('ocl_model_explicit')

mdl_puma560
q0 = p560.qz;
qF = p560.qz;
qmin = p560.qlim(:,1)';
qmax = p560.qlim(:,2)';

T = 10;
N = 50;

wp1 = [-0.2; 0.6; 0.3];
wp2 = [0.4; -0.2; 0.3];

solver = ocl.Solver(T, @p560_ocl_vars_explicit, @p560_ocl_ode_explicit, ...
                    'pathcosts', @p560_ocl_cost_torques, ...
                    'gridconstraints', @(h,k,K,x,p)p560_ocl_waypoints(h,k,x,wp1,wp2), ...
                    'N', N);

solver.setInitialBounds('q', q0);
solver.setInitialBounds('qd', zeros(1,6));

solver.setEndBounds('q', qF)
solver.setEndBounds('qd', zeros(1,6))

solver.setBounds('q', qmin, qmax);
solver.setBounds('tau', -100, 100);

ig = solver.ig();
ig.states.q.set(q0)
ig.integrator.states.q.set(q0);

[sol,times] = solver.solve(ig);

q_traj = sol.states.q.value.';

figure;
hold on; grid on;

p = zeros(3, N+1);
for k=1:N+1
  qk = q_traj(k,:);
  p(:,k) = p560_p_endeff_generated(qk)';
end

plot3(p(1,:), p(2,:), p(3,:))
plot3(wp1(1), wp1(2), wp1(3), 'ro', 'LineWidth', 5);
plot3(wp2(1), wp2(2), wp2(3), 'bo', 'LineWidth', 5);

p560.plot3d(q_traj, 'fps', N/T, 'movie', 'movie');

figure
oclPlot(times.controls, sol.controls.tau')
ylabel('applied torque')
xlabel('time')
legend({'q1','q2','q3','q4','q5','q6'})

