
sim = ocl.Simulator(...
  @sw2_ocl_vars_L, ...
  @sw2_ocl_dae_L);

px = 0;
py = 1; 
theta1 = -10*pi/180;
theta2 = 30*pi/180;
r1 = 1;
r2 = 1;

q = [px;py;theta1;theta2;r1;r2];
qd = zeros(6,1);

sim.reset([q;qd]);

N = 100;
T = 3;
q_traj = zeros(6,N+1);
qd_traj = zeros(6,N+1);
q_traj(:,k) = q;
qd_traj(:,k) = qd;
for k=2:N+1
  x = sim.step(0, T/N);
  q_traj(:,k) = x.q.value;
  qd_traj(:,k) = x.qd.value;
end

%% plot solution 
p = q_traj(1:2,:);
x_max = max(p(:))+1;
[fig,handle] = sw2_draw_prepare();

for k=1:N+1
  sw2_draw_frame(handle, q_traj(:,k), qd_traj(:,k));
  pause(T/N)
end