function Crow = coriolis_row_4(rob,in2,in3)
%% CORIOLIS_ROW_4 - Computation of the robot specific Coriolis matrix row for joint 4 of 6. 
% ========================================================================= 
%    
%    Crow = coriolis_row_4(rob,q,qd) 
%    Crow = rob.coriolis_row_4(q,qd) 
%    
%  Description:: 
%    Given a full set of joint variables and their first order temporal derivatives this function computes the 
%    Coriolis matrix row number 4 of 6 for Puma 560. 
%    
%  Input:: 
%    rob: robot object of Puma 560 specific class 
%    qd:  6-element vector of generalized 
%    q:  6-element vector of generalized 
%    
%  Output:: 
%    Crow:  [1x6] row of the robot Coriolis matrix 
%    
%  Example:: 
%    --- 
%    
%  Known Bugs:: 
%    --- 
%    
%  TODO:: 
%    --- 
%    
%  References:: 
%    1) Robot Modeling and Control - Spong, Hutchinson, Vidyasagar 
%    2) Modelling and Control of Robot Manipulators - Sciavicco, Siciliano 
%    3) Introduction to Robotics, Mechanics and Control - Craig 
%    4) Modeling, Identification & Control of Robots - Khalil & Dombre 
%    
%  Authors:: 
%    This is an autogenerated function. 
%    Code generator written by: 
%    Joern Malzahn 
%    2012 RST, Technische Universitaet Dortmund, Germany 
%    http://www.rst.e-technik.tu-dortmund.de 
%    
%  See also coriolis.
%    
    
% Copyright (C) 1993-2019, by Peter I. Corke 
% Copyright (C) 2012-2019, by Joern Malzahn 
% 
% This file has been automatically generated with The Robotics Toolbox for Matlab (RTB). 
% 
% RTB and code generated with RTB is free software: you can redistribute it and/or modify 
% it under the terms of the GNU Lesser General Public License as published by 
% the Free Software Foundation, either version 3 of the License, or 
% (at your option) any later version. 
%  
% RTB is distributed in the hope that it will be useful, 
% but WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
% GNU Lesser General Public License for more details. 
%  
% You should have received a copy of the GNU Leser General Public License 
% along with RTB.  If not, see <http://www.gnu.org/licenses/>. 
% 
% http://www.petercorke.com 
% 
% The code generation module emerged during the work on a project funded by 
% the German Research Foundation (DFG, BE1569/7-1). The authors gratefully  
% acknowledge the financial support. 

%% Bugfix
%  In some versions the symbolic toolbox writes the constant $pi$ in
%  capital letters. This way autogenerated functions might not work properly.
%  To fix this issue a local variable is introduced:
PI = pi;
   




%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    10-Jul-2019 14:05:57

q2 = in2(:,2);
q3 = in2(:,3);
q4 = in2(:,4);
q5 = in2(:,5);
qd1 = in3(:,1);
qd2 = in3(:,2);
qd3 = in3(:,3);
qd4 = in3(:,4);
qd5 = in3(:,5);
qd6 = in3(:,6);
t2 = cos(q2);
t3 = sin(q3);
t4 = cos(q3);
t5 = sin(q2);
t6 = sin(q5);
t7 = cos(q4);
t8 = sin(q4);
t9 = t7.^2;
t10 = t2.^2;
t11 = t4.^2;
t12 = cos(q5);
t13 = t12.^2;
t14 = q4.*2.0;
t15 = sin(t14);
t16 = qd2.*t15.*1.5108e-4;
t17 = qd3.*t15.*1.5108e-4;
t18 = qd5.*t8.*4.2216e-4;
t19 = qd1.*t2.*t4.*t6.*t7.*1.243584e-3;
t20 = qd1.*t2.*t3.*t6.*t7.*5.8464e-5;
t21 = qd1.*t4.*t5.*t6.*t7.*5.8464e-5;
t22 = qd1.*t2.*t3.*t9.*t13.*2.0216e-4;
t23 = qd1.*t4.*t5.*t9.*t13.*2.0216e-4;
t24 = qd1.*t2.*t4.*t6.*t7.*t12.*2.0216e-4;
t25 = q5.*2.0;
t26 = sin(t25);
Crow = [qd2.*t2.*t3.*(-7.7e-4)-qd3.*t2.*t3.*7.7e-4-qd2.*t4.*t5.*7.7e-4-qd3.*t4.*t5.*7.7e-4-qd1.*t6.*t7.*4.32144e-4-qd1.*t6.*t8.*5.8464e-5-qd2.*t2.*t3.*t9.*3.0216e-4-qd3.*t2.*t3.*t9.*3.0216e-4-qd5.*t2.*t3.*t7.*4.2216e-4-qd2.*t4.*t5.*t9.*3.0216e-4+qd2.*t5.*t6.*t7.*1.243584e-3-qd3.*t4.*t5.*t9.*3.0216e-4-qd5.*t4.*t5.*t7.*4.2216e-4+qd1.*t6.*t8.*t10.*5.8464e-5+qd1.*t6.*t8.*t11.*5.8464e-5-qd1.*t7.*t8.*t10.*3.0216e-4-qd1.*t7.*t8.*t11.*3.0216e-4+qd2.*t2.*t3.*t6.*t7.*5.8464e-5+qd2.*t2.*t4.*t6.*t7.*1.243584e-3+qd3.*t2.*t3.*t6.*t7.*5.8464e-5-qd1.*t2.*t5.*t6.*t8.*1.243584e-3-qd1.*t3.*t4.*t6.*t8.*1.243584e-3+qd3.*t2.*t4.*t6.*t7.*1.243584e-3-qd2.*t3.*t5.*t6.*t7.*1.243584e-3+qd2.*t4.*t5.*t6.*t7.*5.8464e-5-qd3.*t3.*t5.*t6.*t7.*1.243584e-3+qd3.*t4.*t5.*t6.*t7.*5.8464e-5-(qd6.*t2.*t3.*t6.*t8)./5.0e4-qd1.*t4.*t6.*t8.*t10.*1.243584e-3+qd2.*t2.*t3.*t9.*t13.*2.0216e-4+qd5.*t2.*t4.*t6.*t12.*2.0216e-4-(qd6.*t4.*t5.*t6.*t8)./5.0e4+qd3.*t2.*t3.*t9.*t13.*2.0216e-4+qd5.*t2.*t3.*t7.*t13.*2.0216e-4-qd5.*t3.*t5.*t6.*t12.*2.0216e-4+qd2.*t4.*t5.*t9.*t13.*2.0216e-4+qd3.*t4.*t5.*t9.*t13.*2.0216e-4+qd5.*t4.*t5.*t7.*t13.*2.0216e-4-qd1.*t6.*t8.*t10.*t11.*1.16928e-4+qd1.*t7.*t8.*t10.*t11.*6.0432e-4+qd1.*t7.*t8.*t10.*t13.*2.0216e-4+qd1.*t7.*t8.*t11.*t13.*2.0216e-4+qd1.*t2.*t3.*t5.*t6.*t8.*1.243584e-3+qd1.*t3.*t4.*t6.*t8.*t10.*2.487168e-3+qd1.*t2.*t5.*t6.*t8.*t11.*2.487168e-3+qd2.*t2.*t4.*t6.*t7.*t12.*2.0216e-4-qd1.*t2.*t5.*t6.*t8.*t12.*2.0216e-4-qd1.*t3.*t4.*t6.*t8.*t12.*2.0216e-4+qd3.*t2.*t4.*t6.*t7.*t12.*2.0216e-4-qd2.*t3.*t5.*t6.*t7.*t12.*2.0216e-4-qd3.*t3.*t5.*t6.*t7.*t12.*2.0216e-4-qd1.*t7.*t8.*t10.*t11.*t13.*4.0432e-4+qd1.*t2.*t3.*t4.*t5.*t6.*t8.*1.16928e-4-qd1.*t2.*t3.*t4.*t5.*t7.*t8.*6.0432e-4+qd1.*t3.*t4.*t6.*t8.*t10.*t12.*4.0432e-4+qd1.*t2.*t5.*t6.*t8.*t11.*t12.*4.0432e-4+qd1.*t2.*t3.*t4.*t5.*t7.*t8.*t13.*4.0432e-4,t16+t17+t18+t19+t20+t21+t22+t23+t24-qd1.*t2.*t3.*7.7e-4-qd1.*t4.*t5.*7.7e-4-qd2.*t6.*t8.*5.8464e-5-qd3.*t6.*t8.*5.8464e-5-(qd6.*t6.*t7)./5.0e4-qd5.*t8.*t13.*2.0216e-4-qd1.*t2.*t3.*t9.*3.0216e-4-qd1.*t4.*t5.*t9.*3.0216e-4+qd1.*t5.*t6.*t7.*1.243584e-3-qd2.*t4.*t6.*t8.*1.243584e-3-qd2.*t7.*t8.*t13.*2.0216e-4-qd3.*t7.*t8.*t13.*2.0216e-4-qd1.*t3.*t5.*t6.*t7.*1.243584e-3-qd1.*t3.*t5.*t6.*t7.*t12.*2.0216e-4,t16+t17+t18+t19+t20+t21+t22+t23+t24-qd1.*t2.*t3.*7.7e-4-qd1.*t4.*t5.*7.7e-4-qd2.*t6.*t8.*5.8464e-5-qd3.*t6.*t8.*5.8464e-5-(qd6.*t6.*t7)./5.0e4-qd5.*t8.*t13.*2.0216e-4-qd1.*t2.*t3.*t9.*3.0216e-4-qd1.*t4.*t5.*t9.*3.0216e-4-qd2.*t7.*t8.*t13.*2.0216e-4-qd3.*t7.*t8.*t13.*2.0216e-4-qd1.*t3.*t5.*t6.*t7.*1.243584e-3-qd1.*t3.*t5.*t6.*t7.*t12.*2.0216e-4,qd5.*t26.*1.0108e-4,qd2.*t8.*4.2216e-4+qd3.*t8.*4.2216e-4-(qd6.*t6)./5.0e4+qd4.*t26.*1.0108e-4-qd2.*t8.*t13.*2.0216e-4-qd3.*t8.*t13.*2.0216e-4-qd1.*t2.*t3.*t7.*4.2216e-4-qd1.*t4.*t5.*t7.*4.2216e-4+qd1.*t2.*t4.*t6.*t12.*2.0216e-4+qd1.*t2.*t3.*t7.*t13.*2.0216e-4-qd1.*t3.*t5.*t6.*t12.*2.0216e-4+qd1.*t4.*t5.*t7.*t13.*2.0216e-4,t6.*(qd5+qd2.*t7+qd3.*t7+qd1.*t2.*t3.*t8+qd1.*t4.*t5.*t8).*(-2.0e-5)];
