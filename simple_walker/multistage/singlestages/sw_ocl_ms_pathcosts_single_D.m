function sw_ocl_ms_pathcosts_single_D(ch, x, z, u, p)
xpe = x.p(1) - 2;
ch.add(xpe.'*xpe);
ch.add(u.'*u);

