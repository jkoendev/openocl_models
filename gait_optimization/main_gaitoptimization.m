function [sol,times,solver] = main_gaitoptimization

  before_contact = ocl.Stage([], @before_contact_vars, @before_contact_ode, 'N', 3, 'd', 2);
  after_contact = ocl.Stage(1, @after_contact_vars, @after_contact_ode, ...
                            @after_contact_cost, 'N', 5, 'd', 2);

  before_contact.setInitialStateBounds('s', 1);
  before_contact.setInitialStateBounds('v', 0);
  before_contact.setEndStateBounds('s', 0);

  after_contact.setEndStateBounds('s', 1);

  solver = OclSolver({before_contact, after_contact}, {@stage_transition});

  [sol,times] = solver.solve(solver.getInitialGuess());

  figure
  spy(full(solver.jacobian_pattern(sol)))

  % stage 1
  figure;
  subplot(1,2,1)
  hold on; grid on;
  oclPlot(times{1}.states, sol{1}.states.s)
  oclPlot(times{1}.states, sol{1}.states.v)
  legend({'s','v'})
  xlabel('time [s]');
  ylim([-5 3])
  yticks(-5:3)
  title('stage 1')

  % stage 2
  subplot(1,2,2)
  hold on; grid on;
  oclPlot(times{2}.states, sol{2}.states.s)
  oclPlot(times{2}.states, sol{2}.states.v)
  oclStairs(times{2}.states, [sol{2}.controls.F;sol{2}.controls.F(end)])
  legend({'s','v','F'})
  xlabel('time [s]');
  ylim([-5 3])
  yticks(-5:3)
  title('stage 2')

end

% double support
function double_support_vars(vh)

  vh.addState('p', [2,1]);
  vh.addState('v', [2,1]);

  vh.addAlgebraic('fc_front');
  vh.addAlgebraic('fc_back');

  vh.addState('theta');
  vh.addState('theta_dot');

  vh.addState('q1');
  vh.addState('q2');
  vh.addState('q3');
  vh.addState('q4');

  vh.addControl('q1_dot');
  vh.addControl('q2_dot');
  vh.addControl('q3_dot');
  vh.addControl('q4_dot');
end

function double_support_ode(eh,x,z,u,conf)

  g = conf.g;
  m = conf.m;

  p = z.p;
  theta = z.theta;
  fc_front = z.fc_front;
  fc_back = z.fc_back;

  q1 = x.q1;
  q2 = x.q2;
  q3 = x.q3;
  q4 = x.q4;

  front_foot = front_foot_position(p, theta, q1, q2, len_body, len_thigh, len_shank);
  back_foot = back_foot_position(p, theta, q1, q2, len_body, len_thigh, len_shank);

  front_direction = front_foot/norm(front_foot);
  back_direction = back_foot/norm(back_foot);

  a = [0; -g] + ...
      f_front * front_direction / m + ...
      f_back * back_direction / m;

  front_orthorgonal_acceleration = dot(a, front_direction/norm(front_direction));

  eh.setODE('theta', theta_dot);
  eh.setODE('theta_dot', norm(front_direction) * front_orthorgonal_acceleration);

  eh.setODE('p', v);
  eh.setODE('v', a);

  eh.setODE('q1', q1_dot);
  eh.setODE('q2', q1_dot);
  eh.setODE('q3', q1_dot);
  eh.setODE('q4', q1_dot);

  front_foot_vel = front_foot_velocity(p, theta, len_body);
  back_foot_vel = back_foot_velocity(p, theta, len_body);

  eh.setAlgebraicEquation(dot(front_foot_vel,front_foot_vel));
  eh.setAlgebraicEquation(dot(back_foot_vel,back_foot_vel));

end

function initial_conditions(ch)
  % p1 and p2 no velocity
  ch.add(dot(front_foot_vel,front_foot_vel), '==', 0)
  ch.add(dot(back_foot_vel, back_foot_vel), '==', 0)

end

% front leg kinematics
function r = front_shoulder_position(p, theta, len_body)
  r = p + len_body/2 * [cos(theta); sin(theta)];
end

function r = front_shoulder_velocity(v, theta, theta_dot, len_body)
  r = v + len_body/2 * [-sin*(theta); cos(theta)] * theta_dot;
end

function r = front_knee_position(p, theta, q1, len_body, len_thigh)
  angle = theta + q1;
  r = front_shoulder_position(p, theta, len_body) + ...
      len_thigh * [sin(angle); -cos(angle)];
end

function r = front_knee_velocity(v, theta, theta_dot, q1, q1_dot, len_body, len_thigh)
  angle = theta + q1;
  angle_dot = theta_dot + q1_dot;
  r = front_shoulder_velocity(v, theta, theta_dot, len_body) + ...
      len_thigh * [cos(angle); sin(angle)] * angle_dot;
end

function r = front_foot_position(p, theta, q1, q2, len_body, len_thigh, len_shank)
  angle = theta + q1 + q2;
  r = front_knee_positions(p, theta, q1, l_body, l_thigh) + ...
      l_shank * [sin(angle); -cos(angle)];
end

function r = front_foot_velocity(v, theta, theta_dot, q1, q1_dot, q2, q2_dot, len_body, len_thigh, len_shank)
  angle = theta + q1 + q2;
  angle_dot = theta_dot + q1_dot + q2_dot;
  r = front_knee_velocity(v, theta, theta_dot, q1, q1_dot, l_body, l_thigh) + ...
      l_shank * [cos(angle); sin(angle)] * angle_dot;
end

% back leg kinematics
function r = back_shoulder_position(p, theta, len_body)
  r = p - len_body/2 * [cos(theta); sin(theta)];
end

function r = back_knee_position(p, theta, q2, len_body, len_thigh)
  angle = theta + q1;
  r = back_shoulder_position(p, theta, len_body) + ...
      len_thigh * [sin(angle); -cos(angle)];
end

function r = back_foot_position(p, theta, q2, q3, len_body, len_thigh, len_shank)
  angle = theta + q1 + q2;
  r = back_knee_positions(p, theta, q1, len_body, len_thigh) + ...
      len_shank * [sin(angle); -cos(angle)];
end

% sliding friction
function front_sliding_friction()

% front support
function front_support_vars(vh)
  vh.addState('p', [2,1]);
  vh.addState('v', [2,1]);
end

function back_support_ode(eh,x,~,~,~)
  eh.setODE('p', x.v);
  eh.setODE('v', 1/m * Fb - [0;9.81]);
end




function after_contact_cost(ch,~,~,u,~)
  ch.add( u.F^2 );
end

function stage_transition(ch, x0, xF)
  % x0 current stage
  % xF previous stage
  ch.add(x0.s, '==', xF.s);
  ch.add(x0.v, '==', -xF.v/2);
end
