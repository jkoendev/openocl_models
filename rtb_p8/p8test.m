mdl_p8

p8.links(1).qlim=[0 1];
p8.links(2).qlim=[0 1];

p8.links(1).m = 10;
p8.links(1).r = [0,0,0];
p8.links(1).I = [1,1,1];
p8.links(1).Jm = 200e-6;

p8.links(2).m = 0;
p8.links(2).r = [0,0,0];
p8.links(2).I = [1,1,1];
p8.links(2).Jm = 200e-6;

p8.accel([1,1,qr],zeros(1,8),zeros(1,8))

% [t, q, qd] = p8.fdyn(0.01,0,[0,0,qr],zeros(1,8))


p8.fast = 0;
p8.iscsym = 1;

n = p8.n;

q = CasadiArithmetic.Matrix([1,8]);
dq = CasadiArithmetic.Matrix([1,8]);
tau = CasadiArithmetic.Matrix([1,8]);

ddq = p8.accel(q,dq,tau);


ode_fun = casadi.Function('fun',{q.value,dq.value,tau.value},{ddq.value});

q0 = [2,2,qs];
qd0 = q0*0;

x0 = [q0(:); qd0(:)];

tf = 10;
dt = 0.05;

[t,y] = ode45(@robot_dyn, [0:dt:tf], x0, [], p8,ode_fun);


q = y(:,1:n);
qd = y(:,n+1:2*n);

p8.plot(q, 'delay', dt)
