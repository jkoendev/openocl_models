
ocp = ocl.Problem(2, ...
  @sw_ocl_ms_vars_D, ....
  @sw_ocl_ms_dae_D, ...
  @sw_ocl_ms_pathcosts_single_D, ...
  'N', 50, 'd', 2);

ocp.setInitialState('time', 0);

angle = 30*pi/180;

ocp.setInitialBounds('p', [0; cos(angle)]);
ocp.setInitialState('theta1', angle);
ocp.setInitialState('theta2', -angle);
ocp.setInitialState('r1', 1);
ocp.setInitialState('r2', 1);

ocp.setInitialState('v', [0;0]);
ocp.setInitialState('theta1d', 0);
ocp.setInitialState('theta2d', 0);
ocp.setInitialState('r1d', 0);
ocp.setInitialState('r2d', 0);

ocp.setBounds('tau', 0);
ocp.setBounds('r1tau', [30*ones(1,20), 0*ones(1,10), -30*ones(1,20)]);
ocp.setBounds('r2tau', 0);

vars = ocp.getInitialGuess();

% vars.states.p.set([0;1.4]);
% vars.states.theta1.set(0*pi/180);
% vars.states.theta2.set(20*pi/180);
% vars.states.r1.set(1);
% vars.states.r2.set(1);

[vars, times, info] = ocp.solve(vars); 

if ~info.success
  disp('Not solution found.')
  return;
end

%% plot solution 
if ~exist('record_video', 'var')
  record_video = false;
end

if record_video
  filename = ['movie/sim_walker_', datestr(now,'yyyy-mm-dd_HHMMSS')];
  video_writer = VideoWriter(filename);
  video_writer.FrameRate = N/T;
  open(video_writer);
end

x_max = max(vars.states.p(:).value)+1;
[fig,handle] = simple_walker_draw_prepare([-x_max, x_max, -0.1, 2*x_max-0.1]);

t = times.states.value;

for k=2:length(t)
  
  x = vars.states{k};
  
  p = x.p.value;
  theta1 = x.theta1.value;
  theta2 = x.theta2.value;
  r1 = x.r1.value;
  r2 = x.r2.value;
  
  v = x.v.value;
  theta1d = x.theta1d.value;
  theta2d = x.theta2d.value;
  r1d = x.r1d.value;
  r2d = x.r2d.value;

  q = [p; theta1; theta2; r1; r2];
  qd = [v; theta1d; theta2d; r1d; r2d];
  
  simple_walker_draw_frame(handle, q, qd)
  
  if record_video
    frame = getframe(fig);
    writeVideo(video_writer, frame);
  end
  
  pause(t(k)-t(k-1))
  
end

if record_video
  close(video_writer)
end

