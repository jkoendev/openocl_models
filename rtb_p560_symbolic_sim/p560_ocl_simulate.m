addpath('export')
addpath('ocl_model')

load('u.mat')
mdl_puma560

q0 = p560.qn;

system = ocl.System(@p560_ocl_vars, @p560_ocl_dae);
simulator = ocl.Simulator(system);

x0 = simulator.getStates();
x0.q = q0;
x0.qd = zeros(6,1);

simulator.reset(x0);

figure
p560.plot(x0.q.value)

for k=1:10
  [x,~] = simulator.step(zeros(1,6), 0.1);
  p560.plot(x.q.value)
  
end

