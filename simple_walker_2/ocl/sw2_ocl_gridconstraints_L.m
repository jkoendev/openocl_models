function sw2_ocl_gridconstraints_L(ch, k, K, x, p)

if k==1
  [~,~,v1,~] = sw2_fkine(x.q,x.qd);
  ch.add(v1, '==', 0);
end

if k==K
  [~,p2] = sw2_fkine(x.q,x.qd);
  ch.add(p2(2), '==', 0);
end