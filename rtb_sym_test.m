mdl_puma560
serial_link = p560.sym;

n = serial_link.n;

q_sym = sym('q', [1,n], 'real');
qd_sym = sym('qd', [1,n], 'real');
qdd_sym = sym('qdd', [1,n], 'real');
tau_sym = sym('qdd', [1,n], 'real');

% gravity and coriolis torque
tau_out = p560.rne(q_sym,qd_sym,zeros(1,n));
matlabFunction(tau_out,'Vars',{q_sym,qd_sym},'File','tau_coriolis_generated.m','Optimize',false)

q = CasadiVariable.Matrix([1,n]);
qd = CasadiVariable.Matrix([1,n]);
qdd = CasadiVariable.Matrix([1,n]);

tau_coriolis_generate(q,qd)

% qdd_out = serial_link.accel(q,qd,zeros(1,6));