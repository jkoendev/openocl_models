function C = sw_model_C(in1,in2)
%SW_MODEL_C
%    C = SW_MODEL_C(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    11-Sep-2019 15:21:44

r1 = in1(5,:);
r2 = in1(6,:);
r1d = in2(5,:);
r2d = in2(6,:);
theta1 = in1(3,:);
theta2 = in1(4,:);
theta1d = in2(3,:);
theta2d = in2(4,:);
vx = in2(1,:);
vy = in2(2,:);
t2 = cos(theta1);
t3 = cos(theta2);
t4 = sin(theta1);
t5 = sin(theta2);
t6 = r1.*t4.*theta1d;
t7 = r1d.*t4;
t8 = r1.*t2.*theta1d;
t9 = t7+t8+vx;
t11 = r1d.*t2;
t10 = t6-t11+vy;
t12 = t7+t8;
t13 = r2.*t5.*theta2d;
t14 = r2d.*t5;
t15 = r2.*t3.*theta2d;
t16 = t14+t15+vx;
t18 = r2d.*t3;
t17 = t13-t18+vy;
t19 = t14+t15;
t20 = t6-t11;
t21 = (t2.*t9)./1.0e1;
t22 = (t4.*t10)./1.0e1;
t23 = t13-t18;
t24 = (t3.*t16)./1.0e1;
t25 = (t5.*t17)./1.0e1;
C = [-theta1d.*((r1d.*t2)./1.0e1-(r1.*t4.*theta1d)./1.0e1)-theta2d.*((r2d.*t3)./1.0e1-(r2.*t5.*theta2d)./1.0e1)-(r1d.*t2.*theta1d)./1.0e1-(r2d.*t3.*theta2d)./1.0e1;-theta1d.*((r1d.*t4)./1.0e1+(r1.*t2.*theta1d)./1.0e1)-theta2d.*((r2d.*t5)./1.0e1+(r2.*t3.*theta2d)./1.0e1)-(r1d.*t4.*theta1d)./1.0e1-(r2d.*t5.*theta2d)./1.0e1-1.1772e1;-theta1d.*((r1.*t2.*t10)./1.0e1-(r1.*t4.*t9)./1.0e1+(r1.*t4.*t12)./1.0e1-(r1.*t2.*t20)./1.0e1)-r1.*t4.*(9.81e2./1.0e3)+(t10.*t12)./1.0e1-r1d.*(t21+t22+(r1.*t2.^2.*theta1d)./1.0e1+(r1.*t4.^2.*theta1d)./1.0e1)-(t9.*(t6-r1d.*t2))./1.0e1;-theta2d.*((r2.*t3.*t17)./1.0e1-(r2.*t5.*t16)./1.0e1+(r2.*t5.*t19)./1.0e1-(r2.*t3.*t23)./1.0e1)-r2.*t5.*(9.81e2./1.0e3)+(t17.*t19)./1.0e1-r2d.*(t24+t25+(r2.*t3.^2.*theta2d)./1.0e1+(r2.*t5.^2.*theta2d)./1.0e1)-(t16.*(t13-r2d.*t3))./1.0e1;t2.*(9.81e2./1.0e3)-theta1d.*(t21+t22-(t2.*t12)./1.0e1-(t4.*t20)./1.0e1)+(t2.*t9.*theta1d)./1.0e1+(t4.*t10.*theta1d)./1.0e1;t3.*(9.81e2./1.0e3)-theta2d.*(t24+t25-(t3.*t19)./1.0e1-(t5.*t23)./1.0e1)+(t3.*t16.*theta2d)./1.0e1+(t5.*t17.*theta2d)./1.0e1];
