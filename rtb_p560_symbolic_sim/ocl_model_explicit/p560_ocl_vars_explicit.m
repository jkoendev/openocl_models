function p560_ocl_vars_explicit(vars)

  vars.addState('q', [1,6]);
  vars.addState('qd', [1,6]);
  
  vars.addControl('tau', [1,6]);

end