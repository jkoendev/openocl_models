function p560_ocl_codegen_constraints(ch, k, x, wp1, wp2)

  q = x.q;

  p = p560_p_endeff_generated(q);
  pz = p(3);
  ch.add(pz, '<=', 0.6);
  
  if k == 20
    p_target = wp1;
%     p = p560_p_endeff_generated(q);
    p_e = p.' - p_target;
    ch.add(p_e.'*p_e, '==', 0);
  end
  
  if k == 40
    p_target = wp2;
%     p = p560_p_endeff_generated(q);
    p_e = p.' - p_target;
    ch.add(p_e.'*p_e, '==', 0);
  end

end