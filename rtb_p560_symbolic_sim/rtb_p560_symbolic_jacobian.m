addpath('export')

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

torque = p560_torque_generated(q_sym, qd_sym, tau_sym);

torque_jac_q_out = jacobian(torque, q_sym);

[~,~] = mkdir('export');

matlabFunction(torque_jac_q_out,'Vars',{q_sym,qd_sym,tau_sym},'File',fullfile('export','p560_torque_jac_q_generated.m'),'Optimize',true);

addpath('export')