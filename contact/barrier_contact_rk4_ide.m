% impulse differential equation

function barrier_contact_rk4_ide

  x0 = [2;0];
  ts = 0.0001;
  t = 0:ts:3;
  [t,x]= oderk4(@ode, t, x0);
  
  figure
  ph = plot(0, x(1), 'o');
  ylim([-1,10])
  for k=1:size(x,1)
    set(ph, 'Ydata', x(k, 1))
    pause(ts)
  end
  
  figure 
  plot(t,x(:,1))

end

function [t,x] = oderk4(f, t, x0)
  x = zeros(length(x0), length(t));
  x(:,1) = x0;
  
  for k=2:length(t)
    dt = t(k) - t(k-1);
    p = x(1,k-1);
    dv = (p - p*reallog(p));
    dx = [0; dv];
    x(:,k) = rk4(f,dt,t(k),x(:,k-1))+dx;
    
  end
  x = x';
end

function xn = rk4(f,dt,t,x)
  [k1] = f(t, x);
  [k2] = f(t, x + dt/2 * k1);
  [k3] = f(t, x + dt/2 * k2);
  [k4] = f(t, x + dt * k3);
  xn = x+dt/6*(k1 + 2*k2 + 2*k3 + k4);
end

function dx = ode(t,x)

  p = x(1);
  v = x(2);
  
  dx = zeros(2,1);
  dx(1) = v;
  dx(2) = -9.81;
end