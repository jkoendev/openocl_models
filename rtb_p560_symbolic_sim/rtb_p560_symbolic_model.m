mdl_puma560
serial_link = p560.sym;

n = serial_link.n;

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

torque_out = tau_sym - rne(p560, q_sym, qd_sym,zeros(1,n));
mass_out = rne(p560, ones(n,1)*q_sym, zeros(n,n), eye(n), 'gravity', [0 0 0]);

torque_jac_q_out = jacobian(torque_out, q_sym);

[~,~] = mkdir('export');
matlabFunction(torque_out,'Vars',{q_sym,qd_sym,tau_sym},'File',fullfile('export','p560_torque_generated.m'),'Optimize',true);
matlabFunction(mass_out,'Vars',{q_sym,qd_sym},'File',fullfile('export','p560_mass_generated.m'),'Optimize',true);
matlabFunction(torque_jac_q_out,'Vars',{q_sym,qd_sym,tau_sym},'File',fullfile('export','p560_torque_jac_q_generated.m'),'Optimize',true);
addpath('export')
