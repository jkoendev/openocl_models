function sw_ocl_pathcost(ch, x, z, u, p)

ve = x.v(1) - 1;
ch.add(ve^2);

ch.add(1e-6*(x.'*x));
% ch.add(1e-2*(u.'*u));