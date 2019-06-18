q = CasadiVariable.Matrix([1,6]);
qd = CasadiVariable.Matrix([1,6]);
qdd = CasadiVariable.Matrix([1,6]);
tau = CasadiVariable.Matrix([1,6]);

mdl_puma560

oclCreateSymbolicLink(p560)

assert(p560.isdh)

copyfile('zeros.template', 'zeros.m')
rehash;

tau = rne(p560,q,qd,qdd,'slow')

delete('zeros.m')