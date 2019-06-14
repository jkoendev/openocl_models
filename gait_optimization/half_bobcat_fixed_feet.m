%
% Kinematics of the half-bobcat
%
% Position coordinates:
%
%           p1----p0----p2
%          /            /
%         /            /
%        p3           p4
%        \             \
%         \             \
%          p5            p6
%
% Joint angles:
%
%           o------------o
%          / q1)        / q2)
%         /            /
%        o q3)        o q4)
%        \             \
%         \             \
%          o             o
%
% Body dimensions (link lengths):
%
%           o-----r0------o
%          /             /
%         / r1          / r2
%        /             /
%       o             o
%        \             \
%         \ r3          \ r3
%          \             \
%           o             o
%
% The angle theta is the angle of link r0 w.r.t. to the global reference frame
% which is given by the ground plane (line between p5 and p6).
%
%                           p2
%                    _ _ _ /
%            _ _ _ /
%          / theta)
%       p1,p5 ---------------- p6
%
function half_bobcat_fixed_feet

  conf = struct;
  conf.r0 = 1;
  conf.r1 = 0.5;
  conf.r2 = 0.5;
  conf.g = 9.81;
  conf.m = 1;

  p0_init = [0;sqrt(2)/2];
  v0_init = [0;0];
  theta_init = 0;
  q1_init = pi/4;
  q2_init = pi/4;
  q3_init = -pi/2;
  q4_init = -pi/2;
  
  theta_dot_init = 0;
  f1_init = 0;
  f2_init = 0;
  
  
  half_bobcat_draw(p0_init, theta_init, q1_init, q2_init, q3_init, q4_init, conf)
  
  y0 = vertcat(p0_init, v0_init, theta_init, q1_init, q2_init, q3_init, q4_init, theta_dot_init, f1_init, f2_init);
  
  tspan = 0:0.01:2;
  options = odeset('Mass', gait_double_support_mass(), 'RelTol', 1e-4);
                 
  [t,y] = ode15s(@(t,y)dae(y,conf),tspan,y0,options);

end

function half_bobcat_draw(p0, theta, q1, q2, q3, q4, conf)

  r0 = conf.r0;
  r1 = conf.r1;
  r2 = conf.r2;

  p1 = p1fun(p0, theta, r0);
  p2 = p2fun(p0, theta, r0);
  p3 = p3fun(p0, theta, q1, r0, r1);
  p4 = p4fun(p0, theta, q2, r0, r1);
  p5 = p5fun(p0, theta, q1, q3, r0, r1, r2);
  p6 = p6fun(p0, theta, q2, q4, r0, r1, r2);

  figure;
  hold on; grid on;
  
  plot(p0(1), p0(2), 'or', 'MarkerSize', 10)
  plot(p1(1), p1(2), 'ob')
  plot(p2(1), p2(2), 'ob')
  plot(p3(1), p3(2), 'ob')
  plot(p4(1), p4(2), 'ob')
  plot(p5(1), p5(2), 'ob')
  plot(p6(1), p6(2), 'ob')
  
  plot([p5(1), p3(1), p1(1), p2(1), p4(1), p6(1)], [p5(2), p3(2), p1(2), p2(2), p4(2), p6(2)], 'k')
  
  xlim([-2,2])
  ylim([-2,2])
  
end

function r = dae(y, conf)
  x = struct;
  x.p0 = [y(1);y(2)];
  x.v0 = [y(3);y(4)];
  x.theta = y(5);
  x.q1 = y(6);
  x.q2 = y(7);
  x.q3 = y(8);
  x.q4 = y(9);
  
  z = struct;
  z.theta_dot = y(10);
  z.f1 = y(11);
  z.f2 = y(12);
  
  diff = struct;
  diff.p0 = zeros(2,1);
  diff.v0 = zeros(2,1);
  diff.theta = 0;
  diff.q1 = 0;
  diff.q2 = 0;
  diff.q3 = 0;
  diff.q4 = 0;
  
  alg = zeros(3,1);
  
  [diff,alg] = gait_double_support_dae(diff,alg,x,z,conf);
  
  r = vertcat(diff.p0, diff.v0, diff.theta, diff.q1, diff.q2, diff.q3, diff.q4, alg(1), alg(2), alg(3));
  
end

function M = gait_double_support_mass()
  M = diag([1 1 1 1 1 1 1 1 1 0 0 0]);
end

function [diff,alg] = gait_double_support_dae(diff, alg, x, z, conf)

  g = conf.g;
  m = conf.m;
  r0 = conf.r0;
  r1 = conf.r1;
  r2 = conf.r2;

  p0 = x.p0;
  v0 = x.v0;
  theta = x.theta;
  
  theta_dot = z.theta_dot;
  f1 = z.f1;
  f2 = z.f2;

  q1 = x.q1;
  q2 = x.q2;
  q3 = x.q3;
  q4 = x.q4;
  
  q1_dot = 0;
  q2_dot = 0;
  q3_dot = 0;
  q4_dot = 0;

  p5 = p5fun(p0, theta, q1, q2, r0, r1, r2);
  p6 = p6fun(p0, theta, q1, q2, r0, r1, r2);

  p5_direction = p5-p0;
  p6_direction = p6-p0;
  p5_direction = p5_direction/norm(p5_direction);
  p6_direction = p6_direction/norm(p6_direction);
  
  a_mass = [0;-g] + f1*p5_direction/m + f2*p6_direction/m;

  diff.p0 = v0;
  diff.v0  = a_mass;

  diff.q1 = q1_dot;
  diff.q1 = q1_dot;
  diff.q3 = q1_dot;
  diff.q4 = q1_dot;

  alg(1) = a_mass(1);
  alg(2) = a_mass(2);

  % constraint:
  %   cos(theta) = dot((p2-p1), (p6-p5)) / norm(p2-p1) / norm(p6-p5)
  % differentiate to be on velocity level
  p1 = p1fun(p0, theta, r0);
  p2 = p2fun(p0, theta, r0);
  
  v1 = v1fun(v0, theta, theta_dot, r0);
  v2 = v2fun(v0, theta, theta_dot, r0);

  v5 = v5fun(v0, theta, theta_dot, q1, q1_dot, q3, q3_dot, r0, r1, r2);
  v6 = v6fun(v0, theta, theta_dot, q2, q2_dot, q4, q4_dot, r0, r1, r2);

  alg(3) = sin(theta) * theta_dot + ...
           v2'*p6+p2'*v6-v2'*p5-p2'*v5-v1'*p6-p1'*v6+v1'*p5+p1'*v5;
end

function r = p1fun(p0, theta, r0)
  r = p0 - r0 / 2 * [cos(theta); sin(theta)];
end

function r = v1fun(v0, theta, theta_dot, r0)
  r = v0 + r0 / 2 * [sin(theta); -cos(theta)] * theta_dot;
end

function r = p2fun(p0, theta, r0)
  r = p0 + r0 / 2 * [cos(theta); sin(theta)];
end

function r = v2fun(v0, theta, theta_dot, r0)
  r = v0 + r0 / 2 * [-sin(theta); cos(theta)] * theta_dot;
end

function r = p3fun(p0, theta, q1, r0, r1)
  angle = theta + q1;
  r = p1fun(p0, theta, r0) + r1 * [sin(angle); -cos(angle)];
end

function r = v3fun(v0, theta, theta_dot, q1, q1_dot, r0, r1)
  angle = theta + q1;
  r = v1fun(v0, theta, theta_dot, r0) + r1 * [cos(angle); sin(angle)] * (theta_dot + q1_dot);
end

function r = p4fun(p0, theta, q2, r0, r1)
  angle = theta + q2;
  r = p2fun(p0, theta, r0) + r1 * [sin(angle); -cos(angle)];
end

function r = v4fun(v0, theta, theta_dot, q2, q2_dot, r0, r1)
  angle = theta + q2;
  r = v2fun(v0, theta, theta_dot, r0) + r1 * [cos(angle); sin(angle)] * (theta_dot + q2_dot);
end

function r = p5fun(p0, theta, q1, q3, r0, r1, r2)
  angle = theta + q1 + q3;
  r = p3fun(p0, theta, q1, r0, r1) + r2 * [sin(angle); -cos(angle)];
end

function r = v5fun(v0, theta, theta_dot, q1, q1_dot, q3, q3_dot, r0, r1, r2)
  angle = theta + q1 + q3;
  angle_dot = theta_dot + q1_dot + q3_dot;
  r = v3fun(v0, theta, theta_dot, q1, q1_dot, r0, r1) + r2 * [cos(angle); sin(angle)] * angle_dot;
end

function r = p6fun(p0, theta, q2, q4, r0, r1, r2)
  angle = theta + q2 + q4;
  r = p4fun(p0, theta, q2, r0, r1) + r2 * [sin(angle); -cos(angle)];
end

function r = v6fun(v0, theta, theta_dot, q2, q2_dot, q4, q4_dot, r0, r1, r2)
  angle = theta + q2 + q4;
  angle_dot = theta_dot + q2_dot + q4_dot;
  r = v4fun(v0, theta, theta_dot, q2, q2_dot, r0, r1) + r2 * [cos(angle); sin(angle)] * angle_dot;
end
