function p560_ocl_waypoints(ch, k, K, x, ~)

  if k == 5
    p_target = [0.5; 0.5; 0.5];
    p = p560_p_endeff_generated(x.q);
    p_e = p.' - p_target;
    ch.add(p_e.'*p_e);
  end

end