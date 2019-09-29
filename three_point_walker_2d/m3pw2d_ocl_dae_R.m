function m3pw2d_ocl_dae_R(dh, x, z, u, p)

p0 = x.p0;
v0 = x.v0;

p1 = x.p1;
v1 = x.v1;

p2 = x.p2;
v2 = x.v2;

aL = u.aL;

lambda1 = z.lambda1;

contact_force = (p0-p1) * lambda1;
a0 = [0;-m*g] + contact_force;

dh.setODE('p0', v0);
dh.setODE('v0', a0);

dh.setODE('pL', vL);
dh.setODE('vL', aL);

dh.setODE('pR', 0);
