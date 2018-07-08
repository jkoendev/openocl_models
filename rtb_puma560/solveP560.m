FINALTIME = 5;               % horizon length (seconds)
CONTROL_INTERVALS = 20;    % horizon discretization

% Create system and OCP
system = P560System;
ocp = P560OCP(system);

% Get and set solver options
options = Solver.getOptions;
options.iterationCallback = false;
options.nlp.controlIntervals = CONTROL_INTERVALS;
options.nlp.collocationOrder = 3;
options.nlp.ipopt.linear_solver = 'mumps';
options.nlp.solver = 'ipopt';

nlp = Solver.getNLP(ocp,system,options);

nlp.setBounds('q',    -pi, pi); 
nlp.setBounds('dq',    -0.3,    0.3);  

nlp.setInitialBounds('q',     system.robot.qs);        
nlp.setInitialBounds('dq',    zeros(6,1));  

nlp.setParameter('time',  10);

% Create solver
solver = Solver.getSolver(nlp,options);

% Get and set initial guess
initialGuess = nlp.getInitialGuess;

% Run solver to obtain solution
[solution,times] = solver.solve(initialGuess);


figure
system.robot.plot(solution.states.q.value')
hold on
P = solution.integratorVars.algVars.p.value';
plot3(P(:,1),P(:,2),P(:,3))


