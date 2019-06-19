mdl_puma560
n = p560.n;

q = casadi.SX.sym('q', 1, n);
qd = casadi.SX.sym('qd', 1, n);
tau = casadi.SX.sym('tau', 1, n);

torque_sx = p560_torque_generated(q,qd,tau);
mass_sx = p560_mass_generated(q,qd);

% Mass matrix form:
%   M * qdd = torque(q,qd,tau)
%
% As DAE system:
%   qdd = Minv * torque(q,qd,tau)
%   Minv * M  - eye(6) = zeros(6)

