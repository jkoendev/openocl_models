function sw_ocl_ms_gridconstraints_L(ch, k, K, x, p)

if k==K
  q = [x.p; x.theta1; x.theta2; x.r1; x.r2];
  qd = [x.v; x.theta1d; x.theta2d; x.r1d; x.r2d];
  [~,p2,~,~,~,~] = sw_model_fkine(q,qd,0*qd);
  ch.add(p2(2), '==', 0);
end