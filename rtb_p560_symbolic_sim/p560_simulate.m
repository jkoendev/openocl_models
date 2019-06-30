addpath('ode_model')
addpath('export')

mdl_puma560

q0 = p560.qn;
qd0 = [0,0,0,0,0,0];

y0 = [q0, qd0]';

tspan = 0:0.1:1;
options = odeset('Mass',@p560_mass_fcn);
[t_ode15, y_ode15] = ode15s(@p560_ode_fcn, tspan, y0, options);

q_ode15 = y_ode15(:,1:6);
q_sim = struct;
q_sim.t = tspan;
q_sim.q = q_ode15;
save('q_sim','q_sim');

p560.plot(q_ode15)

% compare with RTB
[t q qd] = p560.nofriction.fdyn(tspan(2:end), @(varargin)zeros(1,6), qn);
p560.plot(q)