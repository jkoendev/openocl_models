function sw_ocl_vars(vh)

vh.addState('p', [2,1]);
vh.addState('theta1');
vh.addState('theta2');
vh.addState('r1');
vh.addState('r2');

vh.addState('v', [2,1]);
vh.addState('theta1d');
vh.addState('theta2d');
vh.addState('r1d');
vh.addState('r2d');

% vh.addControl('tau');
% vh.addControl('r1tau');
% vh.addControl('r2tau');

vh.addParameter('E');
