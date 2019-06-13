syms p0 v0 a0
syms theta theta_dot theta_ddot
syms q1 q1_dot q1_ddot q2 q2_dot q2_ddot q3 q3_dot q3_ddot q4 q4_dot q4_ddot 
syms r0 r1 r2 

p1 = p0 - r0/2*[cos(theta);sin(theta)];
v1 = jacobian(p1,[p0,theta]) * [v0;theta_dot];
a1 = jacobian(v1,[p0,theta]) * [v0;theta_dot] + jacobian(v1,[v0,theta_dot]) * [a0;theta_ddot];

p2 = p0 + r0/2*[cos(theta);sin(theta)];
v2 = jacobian(p2,[p0,theta]) * [v0;theta_dot];
a2 = jacobian(v2,[p0,theta]) * [v0;theta_dot] + jacobian(v2,[v0,theta_dot]) * [a0;theta_ddot];

angle = theta + q1;
p3 = p1 + r1 * [sin(angle); -cos(angle)];
v3 = jacobian(p3,[p0,theta,q1]) * [v0;theta_dot;q1_dot];
a3 = jacobian(v3,[p0,theta,q1]) * [v0;theta_dot;q1_dot] + jacobian(v3,[v0,theta_dot,q1_dot]) * [a0;theta_ddot;q1_ddot];

angle = theta + q2;
p4 = p2 + r1 * [sin(angle); -cos(angle)];
v4 = jacobian(p4,[p0,theta,q2]) * [v0;theta_dot;q2_dot];
a4 = jacobian(v4,[p0,theta,q2]) * [v0;theta_dot;q2_dot] + jacobian(v4,[v0,theta_dot,q2_dot]) * [a0;theta_ddot;q2_ddot];

angle = theta + q1 + q3;
p5 = p3 + r2 * [sin(angle); -cos(angle)];
v5 = jacobian(p5,[p0,theta,q1,q3]) * [v0;theta_dot;q1_dot;q3_dot];
a5 = jacobian(v5,[p0,theta,q1,q3]) * [v0;theta_dot;q1_dot;q3_dot] + jacobian(v5,[v0,theta_dot,q1_dot,q3_dot]) * [a0;theta_ddot;q1_ddot;q3_ddot];

angle = theta + q2 + q4;
p6 = p4 + r2 * [sin(angle); -cos(angle)];
v6 = jacobian(p6,[p0,theta,q2,q4]) * [v0;theta_dot;q2_dot;q4_dot];
a6 = jacobian(v6,[p0,theta,q2,q4]) * [v0;theta_dot;q2_dot;q4_dot] + jacobian(v6,[v0,theta_dot,q2_dot,q4_dot]) * [a0;theta_ddot;q2_ddot;q4_ddot];
