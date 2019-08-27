function sw_ocl_vars(vh)

vh.addState('p', [2,1]);
vh.addState('theta1', 'lb', -30*pi/180, 'ub', 30*pi/180);
vh.addState('theta2', 'lb', -30*pi/180, 'ub', 30*pi/180);
vh.addState('r1', 'lb', 0.7, 'ub', 1.3);
vh.addState('r2', 'lb', 0.7, 'ub', 1.3);

vh.addState('v', [2,1]);
vh.addState('theta1d');
vh.addState('theta2d');
vh.addState('r1d', 'lb', -0.1, 'ub', 0.1);
vh.addState('r2d', 'lb', -0.1, 'ub', 0.1);

vh.addControl('tau');
vh.addControl('r1tau');
vh.addControl('r2tau');

vh.addParameter('E');
