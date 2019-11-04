function sw2_ocl_gridconstraints_L(ch, k, K, x, p)

% if k==1
%   [p1,~,v1,~] = sw2_fkine(x.q,x.qd);
%   ch.add(v1(1)^2 + v1(2)^2, '==', 0);
%   ch.add(p1(1)^2+p1(2)^2, '==', 0);
% end
% 
% if k==K
%   [~,p2] = sw2_fkine(x.q,x.qd);
%   ch.add(p2(2), '==', 0);
% end