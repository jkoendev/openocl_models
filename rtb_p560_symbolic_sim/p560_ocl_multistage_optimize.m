addpath('export')
addpath('ocl_model')
addpath('ocl_cost_constraints')

movie = false;

mdl_puma560
q0 = p560.qz;
qF = p560.qz;
qmin = p560.qlim(:,1)';
qmax = p560.qlim(:,2)';

T = 10;
N = 50;

wp1 = [-0.2; 0.6; 0.3];
stage1 = ocl.Stage(T/3, @p560_ocl_vars, @p560_ocl_dae, ...
                    'pathcosts', @p560_ocl_cost_torques, ...
                    'gridconstraints', @(h,k,K,x,p)p560_ocl_endpoint(h,k,K,x,wp1), ...
                    'N', floor(N/3));

stage1.setInitialStateBounds('q', q0);
stage1.setInitialStateBounds('qd', zeros(1,6));

stage1.setStateBounds('q', qmin, qmax);
stage1.setControlBounds('tau', -100, 100);

wp2 = [0.4; -0.2; 0.3];
stage2 = ocl.Stage(T/3, @p560_ocl_vars, @p560_ocl_dae, ...
                    'pathcosts', @p560_ocl_cost_torques, ...
                    'gridconstraints', @(h,k,K,x,p)p560_ocl_endpoint(h,k,K,x,wp2), ...
                    'N', floor(N/3));
                  
stage2.setStateBounds('q', qmin, qmax);
stage2.setControlBounds('tau', -100, 100);
                  
stage3 = ocl.Stage(T/3, @p560_ocl_vars, @p560_ocl_dae, ...
                    'pathcosts', @p560_ocl_cost_torques, ...
                    'N', floor(N/3));

stage3.setEndStateBounds('q', qF)
stage3.setEndStateBounds('qd', zeros(1,6))

stage3.setStateBounds('q', qmin, qmax);
stage3.setControlBounds('tau', -100, 100);

problem = ocl.MultiStageProblem({stage1, stage2, stage3}, ...
  {@p560_ocl_transition, @p560_ocl_transition});

ig = problem.ig();
for k=1:3
  ig{k}.states.q.set(q0)
  ig{k}.integrator.states.q.set(q0);
end

[sol,times] = problem.solve(ig);

%% plot
q_traj = [sol{1}.states.q.value, sol{2}.states.q.value, sol{3}.states.q.value]';

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

if movie
  p560.plot3d(q_traj, 'fps', N/T, 'movie', 'movie');
else
  p560.plot3d(q_traj, 'fps', N/T);
end

% figure
% ocl.plot(times.controls, sol.controls.tau')
% ylabel('applied torque')
% xlabel('time')
% legend({'q1','q2','q3','q4','q5','q6'})

