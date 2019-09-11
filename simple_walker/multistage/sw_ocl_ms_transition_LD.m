function sw_ocl_ms_transition_LD(ch,x,xp)

ch.add(x.p, '==', xp.p);
ch.add(x.theta1, '==', xp.theta1);
ch.add(x.theta2, '==', xp.theta2);
ch.add(x.r1, '==', xp.r1);
ch.add(x.r2, '==', xp.r2);

ch.add(x.v, '==', xp.v);
% ch.add(x.theta1d, '==', xp.theta1d);
% ch.add(x.theta2d, '==', xp.theta2d);
% ch.add(x.r1d, '==', xp.r1d);
% ch.add(x.r2d, '==', xp.r2d);

q = [x.p; x.theta1; x.theta2; x.r1; x.r2];
qd = [x.v; x.theta1d; x.theta2d; x.r1d; x.r2d];
[~,~,v1,v2,~,~] = sw_model_fkine(q,qd,0*qd);
ch.add(v1, '==', 0);
ch.add(v2, '==', 0);

ch.add(x.time, '==', xp.time);

