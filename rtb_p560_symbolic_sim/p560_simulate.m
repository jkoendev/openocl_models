addpath('ode_model')
addpath('export')

mdl_puma560

q0 = p560.qn;
qd0 = [0,0,0,0,0,0];

y0 = [q0, qd0]';

tspan = 0:0.1:1;
options = odeset('Mass',@p560_mass_fcn);
[t, y] = ode15s(@p560_ode_fcn, tspan, y0, options);

q = y(:,1:6);

p560.plot(q)

% compare with RTB
[t q qd] = p560.nofriction.fdyn(1, @(varargin)zeros(1,6), qn);
p560.plot(q)