function sw2_ocl_pathcost(ch, x, z, u, p)

ch.add( 1e-2*(u.'*u) );

% ch.add( -3.*(x.q(1))^2 );