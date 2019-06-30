mdl_puma560
n = p560.n;

q = casadi.SX.sym('q', 1, n);
qd = casadi.SX.sym('qd', 1, n);
tau = casadi.SX.sym('tau', 1, n);

torque_sx = p560_torque_generated(q,qd,tau);
mass_sx = p560_mass_generated(q);

torque_fun = casadi.Function('torque_fun',{q,qd,tau},{torque_sx});
torque_fun.generate('torque_fun.c');
movefile('torque_fun.c', fullfile('export','torque_fun.c'));

torque_jac_q = jacobian(torque_sx,q);

torque_jac_q_fun = casadi.Function('torque_jac_q_fun',{q,qd,tau},{torque_jac_q});
torque_jac_q_fun.generate('torque_jac_q_fun.c');
movefile('torque_jac_q_fun.c', fullfile('export','torque_jac_q_fun.c'));

torque_jac_q_sx = p560_torque_jac_q_generated(q,qd,tau);

torque_jac_q_sym_fun = casadi.Function('torque_jac_q_sym_fun',{q,qd,tau},{torque_jac_q_sx});
torque_jac_q_sym_fun.generate('torque_jac_q_sym_fun.c');
movefile('torque_jac_q_sym_fun.c', fullfile('export','torque_jac_q_sym_fun.c'));

% Mass matrix form:
%   M(q) * qdd = torque(q,qd,tau)
%
% As DAE system:
%   qdd = Minv * torque(q,qd,tau)
%   Minv * M(q) - eye(6) = zeros(6)