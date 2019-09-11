function sw_ocl_ms_transition_DR(ch,x,xp)

ch.add(x.p, '==', xp.p);
ch.add(x.theta1, '==', xp.theta1);
ch.add(x.theta2, '==', xp.theta2);
ch.add(x.r1, '==', xp.r1);
ch.add(x.r2, '==', xp.r2);

ch.add(x.v, '==', xp.v);
ch.add(x.theta1d, '==', xp.theta1d);
ch.add(x.theta2d, '==', xp.theta2d);
ch.add(x.r1d, '==', xp.r1d);
ch.add(x.r2d, '==', xp.r2d);

ch.add(x.time, '==', xp.time);

