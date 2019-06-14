%
% Kinematics of the bobkitten
%
% Position coordinates:
%                          
%                          _  _ 
%                        /      \
%     * _               /  ^   ^ \
%         \             \    ?   /
%          \             \  __  /
%           p4----------p3\/  \/
%          /           /
%         /           /
%        p5          p2
%        \            \
%         \            \
%          p6           p1
%
% Joint angles:
%
%           o------------o
%          / q3)        / q2)
%         /            /
%        o q4)        o q1)
%        \             \
%         \             \ q0)
%          o             o
%
% Body dimensions (link lengths):
%
%           o-----r0------o
%          /             /
%         / r2          / r2
%        /             /
%       o             o
%        \             \
%         \ r1          \ r1
%          \             \
%           o             o
%
function bobkitten_footbase

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

  p = p1(p0_init, 0, conf.r1);
end

function p = p1(p0, q0, r1)
  p = p0 + 
end
