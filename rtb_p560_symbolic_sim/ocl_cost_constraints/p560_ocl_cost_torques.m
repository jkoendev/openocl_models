function p560_ocl_cost_torques(cost, x, z, u, p)
  cost.add(u.'*u);
end