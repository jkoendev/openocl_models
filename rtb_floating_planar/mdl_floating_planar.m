function [ floating_planar ] = mdl_floating_planar()

qz = [0 0 0 0];
qn = [1 1 -pi/6, pi/6];

floating_planar = SerialLink([
    Prismatic('theta' ,0, 'a', 0, 'alpha', -pi/2, 'm', 10, 'r', [0 0 0], 'I', [0 0 0], 'B', 0, 'G', 0, 'Jm', 0, 'standard')
    Prismatic('theta' ,pi/2, 'a', 0, 'alpha', pi/2, 'm', 0, 'r', [0 0 0], 'I', [0 0 0], 'B', 0, 'G', 0, 'Jm', 0, 'standard')
    Revolute('offset',pi,'d', 0, 'a', 1, 'alpha', 0, 'm', 1, 'r', [-0.5 0 0], 'I', [0 0 0], 'B', 0, 'G', 0, 'Jm', 0, 'standard')
    Revolute('d', 0, 'a', 1, 'alpha', 0, 'm', 1, 'r', [-0.5 0 0], 'I', [0 0 0], 'B', 0, 'G', 0, 'Jm', 0, 'standard')
    ], ...
    'name', 'two link floating', ...
    'comment', 'float by Jonas, from Spong, Hutchinson, Vidyasagar', ...
    'configs', {'qz', qz, 'qn', qn});


floating_planar.links(1).qlim = [0 5];
floating_planar.links(2).qlim = [0 5];


% the robot defined above moves in the XY plane and is not influenced by
% the default gravity vector, acting in the Z-direction.  We choose to
% rotate the robot so that it moves in the XZ plane.
floating_planar.base = trotz(pi)*trotx(pi/2);



end

