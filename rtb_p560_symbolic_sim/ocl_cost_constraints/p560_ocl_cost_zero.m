function p560_ocl_cost_zero(cost, x, z, u, p)

  e = x.q.';
  cost.add(e.'*e);

end