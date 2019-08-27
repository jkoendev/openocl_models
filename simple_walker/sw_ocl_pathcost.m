function sw_ocl_pathcost(ch, x, z, u, p)

pe = x.p(2) - 1;

ch.add(1e-2*pe^2);

ve = x.v(1) - 1;
ch.add(10*ve^2);

% ch.add(1e-2*x.v(2)^2);

ch.add(1e-6*(x.'*x));
ch.add(1e-4*(u.'*u));

