function [out1,out2] = sw2_fkine_a(in1,in2,in3)
%SW2_FKINE_A
%    [OUT1,OUT2] = SW2_FKINE_A(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    28-Sep-2019 19:38:26

ax = in3(1,:);
ay = in3(2,:);
r1 = in1(5,:);
r2 = in1(6,:);
r1d = in2(5,:);
r2d = in2(6,:);
r1dd = in3(5,:);
r2dd = in3(6,:);
theta1 = in1(3,:);
theta2 = in1(4,:);
theta1d = in2(3,:);
theta2d = in2(4,:);
theta1dd = in3(3,:);
theta2dd = in3(4,:);
t2 = sin(theta1);
t3 = cos(theta1);
out1 = [ax+theta1d.*(r1d.*t3-r1.*t2.*theta1d)+r1dd.*t2+r1.*t3.*theta1dd+r1d.*t3.*theta1d;ay+theta1d.*(r1d.*t2+r1.*t3.*theta1d)-r1dd.*t3+r1.*t2.*theta1dd+r1d.*t2.*theta1d];
if nargout > 1
    t4 = sin(theta2);
    t5 = cos(theta2);
    out2 = [ax+theta2d.*(r2d.*t5-r2.*t4.*theta2d)+r2dd.*t4+r2.*t5.*theta2dd+r2d.*t5.*theta2d;ay+theta2d.*(r2d.*t4+r2.*t5.*theta2d)-r2dd.*t5+r2.*t4.*theta2dd+r2d.*t4.*theta2d];
end
