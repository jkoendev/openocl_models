
floating_planar = mdl_floating_planar();

floating_planar.fast = 0;

figure;
plot_floating(floating_planar, floating_planar.qn)

n = floating_planar.n;

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

floating_planar.sym;
qdd_out = floating_planar.nofriction.accel(q_sym,qd_sym,tau_sym);


[~,~] = mkdir('export');
matlabFunction(qdd_out,'Vars',{q_sym,qd_sym,tau_sym},'File',fullfile('export','tlf_qdd_generated.m'),'Optimize',true);
addpath('export')


q_sx = casadi.SX.sym('q', 1, n);
qd_sx = casadi.SX.sym('qd', 1, n);
tau_sx = casadi.SX.sym('tau', 1, n);

qdd_sx = tlf_qdd_generated(q_sx, qd_sx, tau_sx);

ode_fun = casadi.Function('fun',{q_sx,qd_sx,tau_sx},{qdd_sx});

q0 = floating_planar.qn;
qd0 = [2,5,1,0];

x0 = [q0(:); qd0(:)];

tf = 2;
dt = 0.04;

floating_planar = mdl_floating_planar();

[t,y] = ode45(@doll_dyn, [0:dt:tf], x0, [], floating_planar,ode_fun);


q = y(:,1:n);
qd = y(:,n+1:2*n);


figure

floating_planar.fast = 0;
plot_floating(floating_planar, q,'delay', dt)
