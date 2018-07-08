mdl_puma560

robot = p560;
robot.fast = 0;
robot.iscsym = 1;

n = robot.n;

q = CasadiArithmetic.Matrix([1,6]);
dq = CasadiArithmetic.Matrix([1,6]);
tau = CasadiArithmetic.Matrix([1,6]);

ddq = robot.accel(q,dq,tau);

ode_fun = casadi.Function('fun',{q.value,dq.value,tau.value},{ddq.value});

q0 = qs;
qd0 = qr*0;

x0 = [q0(:); qd0(:)];

tf = 10;
dt = 0.05;

[t,y] = ode45(@robot_dyn, [0:dt:tf], x0, [], robot,ode_fun);

q = y(:,1:n);
qd = y(:,n+1:2*n);

robot.plot(q, 'delay', dt)
