function sw2_ocl_vars_L(vh)

vh.addState('q', [6,1]);
vh.addState('qd', [6,1]);

vh.addControl('theta2dd');
vh.addControl('r1dd');
vh.addControl('r2dd');

vh.addAlgVar('lambda1');
vh.addAlgVar('theta1dd');

% vh.addParameter('T');
