mdl_puma560
serial_link = p560.sym;

n = serial_link.n;

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

torque_out = tau_sym - p560.rne(q_sym,qd_sym,zeros(1,n));
mass_out = rne(p560, ones(n,1)*q_sym, zeros(n,n), eye(n), 'gravity', [0 0 0]);

[~,~] = mkdir('export');
matlabFunction(torque_out,'Vars',{q_sym,qd_sym,tau_sym},'File','export/p560_torque_generated.m','Optimize',false);
matlabFunction(mass_out,'Vars',{q_sym,qd_sym},'File','export/p560_mass_generated.m','Optimize',false);
addpath('export')
