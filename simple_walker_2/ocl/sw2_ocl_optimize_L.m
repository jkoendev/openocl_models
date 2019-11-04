
problem = ocl.Problem(3, ...
  @sw2_ocl_vars_L, ...
  @sw2_ocl_dae_L, ... 
  'N', 30, 'd', 2);

px = 0;
py = 1; 
theta1 = -5*pi/180;
theta2 = 20*pi/180;
r1 = 1;
r2 = 1;

q = [px;py;theta1;theta2;r1;r2];
qd = zeros(6,1);

vx = 1;

problem.setInitialState('q', q);
problem.setInitialState('qd', qd);

problem.setBounds('theta2dd', 0);
problem.setBounds('r1dd', 0);
problem.setBounds('r2dd', 0);

ig = problem.ig();
% ig.states.qd = 1;
% ig.integrator.algvars = 1;

[vars, times] = problem.solve(ig);

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

p = vars.states.q(1:2,:).value;
x_max = max(p(:))+1;
[fig,handle] = sw2_draw_prepare([-x_max, x_max, -0.1, 2*x_max-0.1]);

t = times.states.value;

for k=2:length(t)
  
  x = vars.states{k};
  
  sw2_draw_frame(handle, x.q.value, x.qd.value)
  
  if record_video
    frame = getframe(fig);
    writeVideo(video_writer, frame);
  end
  
  pause(t(k)-t(k-1))
  
end

if record_video
  close(video_writer)
end
