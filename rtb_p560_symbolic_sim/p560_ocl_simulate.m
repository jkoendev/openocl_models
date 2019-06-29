function p560_ocl_simulate

  global U_STORAGE
  U_STORAGE = 0;
  global EXIT_STORAGE
  EXIT_STORAGE = false;

  system = ocl.System(@p560_vars, @p560_dae);
  simulator = ocl.Simulator(system);
  
  x0 = simulator.getStates();
  x0.q = [0,0,0,0,0,0];
  x0.qd = [0,0,0,0,0,0];
  
  simulator.reset(x0);

  close all
  fig = figure(1);
  set(fig, 'KeyPressFcn', @(src,event) keydown(event));
  set(fig, 'KeyReleaseFcn', @(src,event) keyup());

  mdl_puma560
  
  figure(2);
  p560.plot(x0.q.value)
  
  disp('press key to continue')
  waitforbuttonpress
  while true
    [x,~] = simulator.step(U_STORAGE, 0.01);
    p560.plot(x.q.value)
    
    if EXIT_STORAGE
      break;
    end
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

function keydown(event)
  global U_STORAGE
  
  if event.Key == 'h'
    U_STORAGE = -20;
  elseif event.Key == 'j'
    U_STORAGE = 20;
  elseif event.Key == 'x'
    U_STORAGE = 0;
    global EXIT_STORAGE
    EXIT_STORAGE = true;
  else
    U_STORAGE = 0;
  end
end

function keyup()
  global U_STORAGE
  U_STORAGE = 0;
end