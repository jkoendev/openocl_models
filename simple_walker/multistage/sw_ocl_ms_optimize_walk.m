

% first stage
stageL = ocl.Stage(1, ...
  @sw_ocl_ms_vars_L, ....
  @sw_ocl_ms_dae_L, ...
  @sw_ocl_ms_pathcosts, ...
  'gridconstraints', @sw_ocl_ms_gridconstraints_L, ...
  'N', 30, 'd', 2);

stageL.setInitialStateBounds('time', 0);

stageL.setInitialStateBounds('p', [0;1]);
stageL.setInitialStateBounds('theta1', 0*pi/180);
stageL.setInitialStateBounds('theta2', 50*pi/180);
stageL.setInitialStateBounds('r1', 1);
stageL.setInitialStateBounds('r2', 1);

stageL.setInitialStateBounds('v', [0;0]);
stageL.setInitialStateBounds('theta1d', 0);
stageL.setInitialStateBounds('theta2d', 0);
stageL.setInitialStateBounds('r1d', 0);
stageL.setInitialStateBounds('r2d', 0);

stageL.setControlBounds('tau', -10, 10);
stageL.setControlBounds('r1tau', 0);
stageL.setControlBounds('r2tau', 0);


% second stage
stageD = ocl.Stage(1, ...
  @sw_ocl_ms_vars_D, ....
  @sw_ocl_ms_dae_D, ...
  @sw_ocl_ms_pathcosts, 'N', 20, 'd', 2);

stageD.setControlBounds('tau', 0);
stageD.setControlBounds('r1tau', 0);
stageD.setControlBounds('r2tau', 0);

% stageD.setEndStateBounds('time', 2);

% third stage
stageR = ocl.Stage([], ...
  @sw_ocl_ms_vars_R, ....
  @sw_ocl_ms_dae_R, ...
  'N', 10, 'd', 2);

stageR.setControlBounds('tau', 0);
stageR.setControlBounds('r1tau', 0.0);
stageR.setControlBounds('r2tau', 0);

stageR.setEndStateBounds('time', 3);


% combined problem
% ocp = ocl.MultiStageProblem({stageL, stageD, stageR}, ... 
%   {@sw_ocl_ms_transition_LD, @sw_ocl_ms_transition_DR});

ocp = ocl.MultiStageProblem({stageL, stageD}, ... 
  {@sw_ocl_ms_transition_LD});

vars = ocp.getInitialGuess();

[vars, times] = ocp.solve(vars); 

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

x_max = 0;
for j=1:length(vars)
  x_max = max([x_max;abs(vars{j}.states.p(:).value)]);
end

[fig,handle] = simple_walker_draw_prepare([-x_max-1, x_max+1, -0.1, 2*x_max-0.1]);

for j=1:length(vars)
  
  vj = vars{j};
  tj = times{j};

  t = tj.states.value;

  for k=2:length(t)

    x = vj.states{k};

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
  
end

if record_video
  close(video_writer)
end

