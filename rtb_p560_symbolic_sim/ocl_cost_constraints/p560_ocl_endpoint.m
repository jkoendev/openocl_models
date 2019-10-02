function p560_ocl_endpoint(ch, k, K, x, wp1)

  if k == K
    p_target = wp1;
    p = p560_p_endeff_generated(x.q);
    p_e = p.' - p_target;
    ch.add(p_e.'*p_e, '==', 0);
  end

end