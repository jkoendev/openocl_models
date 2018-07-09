
[ floating_planar ] = mdl_floating_planar();

figure;
plot_floating(floating_planar,floating_planar.qn)


floating_planar.fast = 0;
floating_planar.iscsym = 1;

n = floating_planar.n;

q = CasadiArithmetic.Matrix([1,n]);
dq = CasadiArithmetic.Matrix([1,n]);
tau = CasadiArithmetic.Matrix([1,n]);


ddq = floating_planar.accel(q,dq,tau);


ode_fun = casadi.Function('fun',{q.value,dq.value,tau.value},{ddq.value});

q0 = floating_planar.qn;
qd0 = [2,5,0,0];

x0 = [q0(:); qd0(:)];

tf = 2;
dt = 0.04;

[t,y] = ode45(@doll_dyn, [0:dt:tf], x0, [], floating_planar,ode_fun);


q = y(:,1:n);
qd = y(:,n+1:2*n);

figure
plot_floating(floating_planar,q,'delay', dt)
