%
% Kinematics of the bobkitten
%
% Position coordinates:
%                          
%                          _  _ 
%                        /      \
%       _               /  ^   ^ \
%         \             \    ?   /
%          \             \  __  /
%           p4----------p3\/  \/
%          /            /
%         /            /
%        p5           p2
%        \             \
%         \             \
%          p6            p1
%
% Joint angles:
%
%           o------------o
%          / q3)        / q2)
%         /            /
%        o q4)        o q1)
%        \             \
%         \             \
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
% The angle theta is the angle of link r0 w.r.t. to the global reference frame
% which is given by the ground plane (line between p5 and p6).
%
%                           p2
%                    _ _ _ /
%            _ _ _ /
%          / theta)
%       p1,p5 ---------------- p6