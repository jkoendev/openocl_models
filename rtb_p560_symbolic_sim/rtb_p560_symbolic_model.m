mdl_puma560
p560 = p560.sym;

n = p560.n;

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

T = p560.fkine(q_sym);
p_endeff = T.transl;

torque_out = tau_sym - rne(p560, q_sym, qd_sym,zeros(1,n));
mass_out = rne(p560, ones(n,1)*q_sym, zeros(n,n), eye(n), 'gravity', [0 0 0]);



[~,~] = mkdir('export');

matlabFunction(p_endeff,'Vars',{q_sym},'File',fullfile('export','p560_p_endeff_generated.m'),'Optimize',true);
matlabFunction(torque_out,'Vars',{q_sym,qd_sym,tau_sym},'File',fullfile('export','p560_torque_generated.m'),'Optimize',true);
matlabFunction(mass_out,'Vars',{q_sym},'File',fullfile('export','p560_mass_generated.m'),'Optimize',true);

addpath('export')
