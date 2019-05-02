function barrier_contact_rk4

  x0 = [1;0];
  ts = 0.001;
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
    x(:,k) = rk4(f,dt,t(k),x(:,k-1));
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
  
  h = -p;
  
  if h > 0
    force = 1e5;
  else
    force = -reallog(-h);
  end

  dx = zeros(2,1);
  dx(1) = v;
  dx(2) = force - 9.81 - min(force,100)*v;

end