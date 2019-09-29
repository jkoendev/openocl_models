function sw2_ocl_vars_L(vh)

vh.addState('q');
vh.addState('qd');

vh.addControl('theta2dd');
vh.addControl('r1dd');
vh.addControl('r2dd');

vh.addAlgVar('lambda1');
vh.addControl('theta1dd');
