function TestCollision1D

m = 1;
g = -9.81;
h = 0.02;

p0 = 10;
v0 = 0;

tau = 3;

figure

x = [p0;v0;0];

for t=0:h:3
%   p = x(1);
%   v = x(2);
%   Fc = x(3);
% ceq1 = p - p0 - h*v;
% ceq2 = v - v0 - h*(g+Fc/m);
  
  lb = [0;-inf;0];
  Aeq = [1,-h,0;0,1,-h/m;0,0,0];
  beq = [p0;v0+h*g;0];
  
  opt = optimset;
  opt.Display = 'off';
  x = fmincon(@(x)0,x,[],[],Aeq,beq,lb,[],@mycon,opt);
  
  p0 = x(1);
  v0 = x(2);
  
  plot(0,p0,'o');
  title(t)
  xlim([-1,1])
  ylim([-1,11])
  pause(h)
  
end

  function [c,ceq] = mycon(x)
    p = x(1);
    Fc = x(3);
    
    ceq = Fc * p - tau;
   
    c = [];
    
  end

end