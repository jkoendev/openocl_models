function pc = sw_model_pc(in1)
%SW_MODEL_PC
%    PC = SW_MODEL_PC(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    11-Sep-2019 15:21:45

py = in1(2,:);
r1 = in1(5,:);
r2 = in1(6,:);
theta1 = in1(3,:);
theta2 = in1(4,:);
pc = [py-r1.*cos(theta1);py-r2.*cos(theta2)];
