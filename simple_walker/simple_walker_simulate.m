if ~exist('record_video', 'var')
  record_video = false;
end
  
T = 2;
N = 100;

if record_video
  filename = ['sim_walker_', datestr(now,'yyyy-mm-dd_HHMMSS')];
  video_writer = VideoWriter(filename);
  video_writer.FrameRate = N/T;
  open(video_writer);
end

px = 0;
py = 3; 
theta1 = 0*pi/180;
theta2 = 20*pi/180;
r1 = 1;
r2 = 1;

q = [px;py;theta1;theta2;r1;r2];
qd = zeros(6,1);

y = [q;qd];

tspan = linspace(0,T,N);
options = odeset('Mass', @(t,y) blkdiag(eye(6), sw_model_M(y(1:6))) );
[t,Y] = ode15s(@simple_walker_ode, tspan, y, options);

% draw
[fig,h] = simple_walker_draw_prepare();
q = y(1:6);
qd = y(7:12);
simple_walker_draw_frame(h, q, qd);

for k=2:size(Y,1)
  y = Y(k,:)';
  q = y(1:6);
  qd = y(7:12);
  simple_walker_draw_frame(h, q, qd);
  
  if record_video
    frame = getframe(fig);
    writeVideo(video_writer, frame);
  end
  pause(t(k)-t(k-1))
end

if record_video
  close(video_writer)
end

