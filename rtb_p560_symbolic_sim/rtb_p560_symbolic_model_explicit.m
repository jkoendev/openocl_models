mdl_puma560
p560 = p560.sym;

n = p560.n;

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

qdd_out = p560.nofriction.accel(q_sym, qd_sym, tau_sym);

[~,~] = mkdir('export');

matlabFunction(qdd_out,'Vars',{q_sym,qd_sym,tau_sym},'File',fullfile('export','p560_qdd_generated.m'),'Optimize',true);

addpath('export')
