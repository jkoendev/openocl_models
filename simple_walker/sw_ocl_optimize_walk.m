opts = struct;
opts.ipopt = struct;
opts.ipopt.warm_start_init_point = 'yes';
opts.ipopt.mu_target = 0.1;
opts.ipopt.mu_init = 0.1;

solver = ocl.Solver(0.8, ...
  @sw_ocl_vars, ....
  @sw_ocl_ode, @sw_ocl_pathcost, 'N', 100, 'd', 2, ...
  'casadi_options', opts);

solver.setInitialState('p', [0,1]);
solver.setInitialState('theta1', 30*pi/180);
solver.setInitialState('theta2', -30*pi/180);
solver.setInitialState('r1', 1);
solver.setInitialState('r2', 1);

solver.setInitialState('v', 0);
solver.setInitialState('theta1d', 0);
solver.setInitialState('theta2d', 0);
solver.setInitialState('r1d', 0);
solver.setInitialState('r2d', 0);

E_list = [200,300, 600, 800, 1000, 1500];
solver.setParameter('E', E_list(1));
ig = solver.getInitialGuess;

for k=1:length(E_list)
  solver.setParameter('E', E_list(k));

  [sol, times] = solver.solve(ig);  
  ig = sol;
end


%% plot solution
[fig,h] = simple_walker_draw_prepare(max(sol.states.p(:).value));

t = times.states.value;

for k=2:length(t)
  
  p = sol.states.p(:,:,k).value;
  theta1 = sol.states.theta1(:,:,k).value;
  theta2 = sol.states.theta2(:,:,k).value;
  r1 = sol.states.r1(:,:,k).value;
  r2 = sol.states.r2(:,:,k).value;
  
  v = sol.states.v(:,:,k).value;
  theta1d = sol.states.theta1d(:,:,k).value;
  theta2d = sol.states.theta2d(:,:,k).value;
  r1d = sol.states.r1d(:,:,k).value;
  r2d = sol.states.r2d(:,:,k).value;

  q = [p; theta1; theta2; r1; r2];
  qd = [v; theta1d; theta2d; r1d; r2d];
  
  simple_walker_draw_frame(h, q, qd)
  
  pause(t(k)-t(k-1))
  
end

