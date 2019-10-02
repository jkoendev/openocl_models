function p560_ocl_waypoints(ch, k, K, x, wp1, wp2)

  if k == 20
    p_target = wp1;
    p = p560_p_endeff_generated(x.q);
    p_e = p.' - p_target;
    ch.add(p_e.'*p_e, '==', 0);
  end
  
  if k == 40
    p_target = wp2;
    p = p560_p_endeff_generated(x.q);
    p_e = p.' - p_target;
    ch.add(p_e.'*p_e, '==', 0);
  end

end